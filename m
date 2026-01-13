Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2E39C9EC8C
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Jan 2026 10:13:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vfbPL-0005Or-Dj; Tue, 13 Jan 2026 05:13:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vfbPH-0005Mh-GU
 for qemu-devel@nongnu.org; Tue, 13 Jan 2026 05:13:48 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vfbPB-0008TZ-Hq
 for qemu-devel@nongnu.org; Tue, 13 Jan 2026 05:13:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1768299220;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=vWwcXXn22ooV70rzjZLwpn6AoemTIvSsLVMxq6Qc7wQ=;
 b=b5IQ20nOu+UUadMwjyUdwbewvK+jqqszdGf+o7eyOWSdodEO5797gnwLu7GjzrA6dT5TYA
 IYfpxZOzXKcmrdAl9Md+jNuqUiPGQlVrv4bSw+JyWtF2vW8958zvNfrUFHpBMIcqFuWz+R
 XGlnMOh2KpCyfd0u2BIXT3SLYeQcK7g=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-663-zw2M6h2MPx2cg2D9IAsiUA-1; Tue, 13 Jan 2026 05:13:38 -0500
X-MC-Unique: zw2M6h2MPx2cg2D9IAsiUA-1
X-Mimecast-MFC-AGG-ID: zw2M6h2MPx2cg2D9IAsiUA_1768299217
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-43102ac1da8so5969306f8f.2
 for <qemu-devel@nongnu.org>; Tue, 13 Jan 2026 02:13:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1768299217; x=1768904017; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=vWwcXXn22ooV70rzjZLwpn6AoemTIvSsLVMxq6Qc7wQ=;
 b=In4XcvDYYDosHwzmgLYzA9L8pTrNNyXtKLFcORnorr7T2MUd2BKssZGTQvou/AjiOG
 fB3kSVrbray21qwOT9Q2XaysV13LsonXLrizTK980dLRXHKh8IcyaTHeE81AD/S9XTbI
 2jS0t6Yd62ZUTrd9LTtVPpdrb/7R09kzUDeh/iY0vME/fnM1jrkqnUxbgPL0oERv1kPp
 4xBPzZlkiNb9rqo2efKY9it3asMCEvX9oJJHWcCCTcHWj32aGD9bd3GTE1OzA2bULCXd
 vFAxezKAmKTUrU4P9h2ev4jfQrTXI6as7I18U5xhT18DJR+gYou63GtEkGWm1cH8b2uv
 P8rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768299217; x=1768904017;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vWwcXXn22ooV70rzjZLwpn6AoemTIvSsLVMxq6Qc7wQ=;
 b=X9/c0q7wUUvaqywjQ+c+FQIr9PRjF89cH3pn6xKt9EAcQQgCuMI4FJpYuBdsHtB1GS
 jP/Wg2Rn0U74AD2mZjK8FChtYNDuAraXnMrWMG0HqMqbqFIRXZnA/kiqlFehM62giWJz
 hoH+JmVeAsMO0QoEKwceq4FIwmjz8BB6iqskK7soInX0ZivMRQCA4gEPZxR7PDUkaJjZ
 TI+Vq4tvrC2v0jDNcXX8WFu5I/4waWU1tw1z1XUiVtybie8yr82l5VwPXcNapdG1mUDO
 jdW6cRwYjaQkzGiuJfyczrfOGcF8NaZb28l5Tv0kumN/44BKkVtrzYfXpa1tTW/wjM4v
 szqQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXz3NMgMO05R9dO/uNWvcJEViRnLnD9bCicxoY0lgWSbjf7g9gtPVtKS71BORED00N4PfCptboaCq1T@nongnu.org
X-Gm-Message-State: AOJu0YzuBGX0kf//uGVc8qO8xIb0Vc9jY4sgOL1ZNGEUfJqy0OGoWdkt
 aWWOm7Gc792J27peT/CE6vwMp4ZyOYnyGMqMu/6vfwBjTU2FZqhKi30F+4dgNw8vEfgbnQ9z3nK
 8vNXyI9Wz84+EObiAjS2/vST9PLhspuLC6dFyE+y8p+tZxC/f2k5GICBP
X-Gm-Gg: AY/fxX56fE88iBLrY89keBlIFfydOCbYeKQkYCtF72crRKYhupR7PL00xr65oYbSrnr
 iMjmhFEd9DDJ85q8z8VZBaz2Tx7WZK8yGL3FSI9TdyFnplo0PngVEr4mZmVQFxh5Jy35wBAi37b
 ElmHfkQ7/c/yS3iw+A3ApPD9mwpXUsp7/AuF+uErsYOvTtYgAT6Wp8tJVi9X5NDanLgDJHwFzyw
 Aibq5spQ5ZiGyqwPghApotfhQTOeTERztNyg0hR2BHTpv8ucXSHHBoFu2153ATfXbaZa4PzlWAM
 qov1kl8Le8VYXXlaqKpYrc04PKobm/76sc8QqOw+18LwO7a27ynRJLCj5a20u0wxggvau4V21Xj
 AOYyJ2A8=
X-Received: by 2002:a05:6000:1a8b:b0:430:f742:fbb9 with SMTP id
 ffacd0b85a97d-432c3775a58mr26833906f8f.23.1768299216781; 
 Tue, 13 Jan 2026 02:13:36 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF41yIoHh9yXGU5GGWucezI3+fPsofabm7eefrmffK8oObokzD5/X+6AMgd+sl8XNhOTUVPbg==
X-Received: by 2002:a05:6000:1a8b:b0:430:f742:fbb9 with SMTP id
 ffacd0b85a97d-432c3775a58mr26833857f8f.23.1768299216342; 
 Tue, 13 Jan 2026 02:13:36 -0800 (PST)
Received: from [192.168.0.9] ([47.64.113.220])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-432bd5fe83bsm43446084f8f.38.2026.01.13.02.13.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 13 Jan 2026 02:13:35 -0800 (PST)
Message-ID: <bdedb0fd-e7e3-4b7a-a777-346da5808139@redhat.com>
Date: Tue, 13 Jan 2026 11:13:34 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 29/29] docs/system/s390x: Add secure IPL documentation
To: Zhuoying Cai <zycai@linux.ibm.com>, berrange@redhat.com,
 richard.henderson@linaro.org, david@redhat.com, jrossi@linux.ibm.com,
 qemu-s390x@nongnu.org, qemu-devel@nongnu.org, brueckner@linux.ibm.com
Cc: walling@linux.ibm.com, jjherne@linux.ibm.com, pasic@linux.ibm.com,
 borntraeger@linux.ibm.com, farman@linux.ibm.com, mjrosato@linux.ibm.com,
 iii@linux.ibm.com, eblake@redhat.com, armbru@redhat.com, alifm@linux.ibm.com
References: <20251208213247.702569-1-zycai@linux.ibm.com>
 <20251208213247.702569-30-zycai@linux.ibm.com>
Content-Language: en-US
From: Thomas Huth <thuth@redhat.com>
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20251208213247.702569-30-zycai@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 08/12/2025 22.32, Zhuoying Cai wrote:
> Add documentation for secure IPL
> 
> Signed-off-by: Collin Walling <walling@linux.ibm.com>
> Signed-off-by: Zhuoying Cai <zycai@linux.ibm.com>
> ---
...
> @@ -77,3 +93,83 @@ Configuration:
>   .. code-block:: shell
>   
>       qemu-system-s390x -machine s390-ccw-virtio,secure-boot=on,boot-certs.0.path=/.../qemu/certs,boot-certs.1.path=/another/path/cert.pem ...
> +
> +
> +Constraints
> +===========
> +
> +The following constraints apply when attempting to secure IPL an s390 guest:
> +
> +- z16 CPU model

Should this mention the "qemu" CPU model, too?

> +- certificates must be in X.509 PEM format
> +- only support for SCSI scheme of virtio-blk/virtio-scsi devices
> +- a boot device must be specified
> +- any unsupported devices (e.g., ECKD and VFIO) or non-eligible devices (e.g.,
> +  Net) will cause the entire boot process terminating early with an error

s/(e.g., Net)/(e.g. network)/

> +  logged to the console.
> +
> +
> +Secure IPL Quickstart
> +=====================
> +
> +Build QEMU with gnutls enabled
> +-------------------------------
> +
> +.. code-block:: shell
> +
> +    ./configure … --enable-gnutls
> +
> +Generate certificate (e.g. via certtool)
> +----------------------------------------
> +
> +A private key is required before generating a certificate. This key must be kept
> +secure and confidential.
> +
> +Use an RSA private key for signing.
> +
> +.. code-block:: shell
> +
> +    certtool --generate-privkey > key.pem
> +
> +A self-signed certificate requires the organization name. Use the ``cert.info``
> +template to pre-fill values and avoid interactive prompts from certtool.
> +
> +.. code-block:: shell
> +
> +    cat > cert.info <<EOF
> +    cn = "My Name"
> +    expiration_days = 36500
> +    cert_signing_key
> +    EOF
> +
> +    certtool --generate-self-signed \
> +             --load-privkey key.pem \
> +             --template cert.info \
> +             --hash=SHA256 \
> +             --outfile cert.pem
> +
> +Sign Images (e.g. via sign-file)
> +--------------------------------
> +
> +- signing must be performed on a KVM guest filesystem
> +- sign-file script used in the example below is located within the kernel source
> +  repo
> +
> +.. code-block:: shell
> +
> +    ./sign-file sha256 key.pem cert.pem /boot/vmlinuz-…
> +    ./sign-file sha256 key.pem cert.pem /usr/lib/s390-tools/stage3.bin
> +
> +Run zipl with secure boot enabled
> +---------------------------------
> +
> +.. code-block:: shell
> +
> +    zipl --secure 1 -V
> +
> +Start Guest with Cmd Options

"Command line options for starting the guest" ?

> +----------------------------
> +
> +.. code-block:: shell
> +
> +    qemu-system-s390x -machine s390-ccw-virtio,secure-boot=on,boot-certs.0.path=cert.pem ...

  Thomas


