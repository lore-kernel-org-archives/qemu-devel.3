Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70524D4A607
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Jan 2026 07:46:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vgeWt-0003zU-Qv; Fri, 16 Jan 2026 02:45:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vgeWJ-0003iq-Eh
 for qemu-devel@nongnu.org; Fri, 16 Jan 2026 02:45:29 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vgeWH-0000e7-Sr
 for qemu-devel@nongnu.org; Fri, 16 Jan 2026 02:45:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1768549518;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=+8c6+Zq899YlfYFOY4yb6ndoINetI9NkLn7TQHRS2Ro=;
 b=L9fMH9BECPg9SjG19PKZefSAOGPWAqvFDgj+R6WrRBUZ9MR4aVhrma7rXN7Zn20w4Wo4eG
 PGBP7PWhCRUDwWO9GN6lOiaY9vG/YN2p3kJr9QHSbiOr3sTdkFyixVxmzOD3yFCMeeeTc0
 5oH0owkd3RYCrc+ifld+HR7rqhlmE5o=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-606-tT5n8BamNcOwqZPP-2jc7Q-1; Fri, 16 Jan 2026 02:45:16 -0500
X-MC-Unique: tT5n8BamNcOwqZPP-2jc7Q-1
X-Mimecast-MFC-AGG-ID: tT5n8BamNcOwqZPP-2jc7Q_1768549515
Received: by mail-ed1-f70.google.com with SMTP id
 4fb4d7f45d1cf-64d01707c32so2482665a12.1
 for <qemu-devel@nongnu.org>; Thu, 15 Jan 2026 23:45:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1768549515; x=1769154315; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=+8c6+Zq899YlfYFOY4yb6ndoINetI9NkLn7TQHRS2Ro=;
 b=VjRcRjeIWXkARgAWqmBSNw8CvCdhs5AuCBs65rBDPrHJoXzxOWwRfBl9Ja1ab7q+bM
 i4m8laRQu9sQd0aXTOnOH8MPOnTXjP4kX3va/bzMe0INRlthj0aA2sIFaP8275fIDVvC
 SUw1Po9obIIOdxB06iH4ceattXrJg4IFbgzqxqdl7oIUgWLOGG25Uuy9PfdLWoBIQcAC
 WjcGdEl/Et0/ePDb7KTNHgyTlsDIXa05z96FMRmmNqn1piYq4v6TtqbK9Rad6bNGhAxF
 HOfrJPH91EyWI0ckdEkJJp7Qizsx+W+6C5bCOvufn+guts6t3m/AB/Sy8BRr7VTKPUhS
 QXgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768549515; x=1769154315;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+8c6+Zq899YlfYFOY4yb6ndoINetI9NkLn7TQHRS2Ro=;
 b=SXRZ5N/ctGdF54Vrd7s2L9Y6VCpjgTKgVSEIkN+T4AyTqtj8I3zEIxixmgl8oEkkn+
 tTIzRA0t3WTx/FqLu3HJtFglNPRiaXjVRuJLDAnKHOcIasKgJe3OJZGbKoLUBOA8Aeua
 iwPJCqOmgVXMrhlsiTJi4tJB9goMzGKWErAdzLZYwSzXQQbMBrVi80Vlj3ZYP1urdwSf
 Unl5rXSlpnnjNPuObC/Y9P1uvxVd7ejtR9sOcicvK2oFkDzemVRIvYp3zphZ+i0TKcR1
 HYV6wb5w3EWSpZBXceky8nrxxgikY3KARj1wZHJ6Hgh3lTDoq17YENRV7tDB6V8jH/In
 H+Vw==
X-Forwarded-Encrypted: i=1;
 AJvYcCX4fKM4AqXnPbJSqfNZWQGk82LmqZQZR3IfW3U86kvSpocsPl3f9ToWgBj85ub3wTF6dQJXg6bgj3Kh@nongnu.org
X-Gm-Message-State: AOJu0YxAVETQ2tEl+4uOkHnxNJ8XpCoytKS0/nUvKQbBMcB2q/3Yqe0/
 isR2zN5mpY6f75blZUu3s89YtOsfjidNk3faPNhTqQrVrH8RBgUhSA8XSz7iWv07qjpZZS6vBMn
 RxWVyKabKEk1SHS7+baceuy9/xE1ep0twshxWdJKL3HxrHuHLYmZ28FQy
X-Gm-Gg: AY/fxX4z3SF14/ixYEdmik5y/Aw4W3FQYQFierCkBeac7vu3I3JhkWRxcrHWaxcMVJ3
 h00kwKGRFximC/oLA/XX/WimzcmI7QiK6KOzTiS9WEMXU0DiUKgpKWN/Px2znFyURUO1OPj23Lq
 BGQVYcDYbcsTNezCvhryf4JK43gWoMOj30qTA3ABL3LS39feeQv31GTYhF93wY7l+tL7e2aeYJc
 VjJS8td0oPcS3hMdvHb3gYmqKThnsJYOc89nN563OtCVfSjY3cVfqjm7cLbElsSdCXvSjbqA/7C
 TZTldavZex84TpqNddlZIN+PKr74uFmnq++DA3kTydJva7AGeVUBZvxFG0OvAEusBI+095r4Z+k
 U0wKZ9tU=
X-Received: by 2002:a17:907:9713:b0:b80:402e:6e77 with SMTP id
 a640c23a62f3a-b8796b9da5fmr146802566b.54.1768549515372; 
 Thu, 15 Jan 2026 23:45:15 -0800 (PST)
X-Received: by 2002:a17:907:9713:b0:b80:402e:6e77 with SMTP id
 a640c23a62f3a-b8796b9da5fmr146800366b.54.1768549514983; 
 Thu, 15 Jan 2026 23:45:14 -0800 (PST)
Received: from [192.168.0.9] ([47.64.113.220])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b87959fa4f3sm156185866b.50.2026.01.15.23.45.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 15 Jan 2026 23:45:14 -0800 (PST)
Message-ID: <c266cd24-61e1-4f40-811c-9b7e5db3cc17@redhat.com>
Date: Fri, 16 Jan 2026 08:45:13 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 11/14] tests: validate dmsetup result in test 128
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org
Cc: John Snow <jsnow@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 qemu-block@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Cleber Rosa <crosa@redhat.com>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>, Kevin Wolf <kwolf@redhat.com>
References: <20260115164756.799402-1-berrange@redhat.com>
 <20260115164756.799402-12-berrange@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20260115164756.799402-12-berrange@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 15/01/2026 17.47, Daniel P. Berrangé wrote:
> The I/O test 128 uses 'dmsetup create' to create a device, optionally
> using sudo to elevate privileges.
> 
> This dmsetup command works in GitLab CI, however, the test then fails
> with a missing device name:
> 
>    1..1
>    # running raw 128
>    not ok raw 128
>    ----------------------------------- stderr -----------------------------------
>    --- /builds/berrange/qemu/tests/qemu-iotests/128.out
>    +++ /builds/berrange/qemu/build/scratch/raw-file-128/128.out.bad
>    @@ -1,5 +1,5 @@
>     QA output created by 128
> 
>     == reading from error device ==
>    -read failed: Input/output error
>    +qemu-io: can't open device /dev/mapper/eiodev16546: Could not open '/dev/mapper/eiodev16546': No such file or directory
>     *** done
> 
>    (test program exited with status code 1)
> 
> It is believed that this is due to the build env using a manually
> populated /dev, such that the device mapper node won't ever appear.
> It is not a race, since a test adding a sleep did not result in the
> device appearing.
> 
> Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> ---
>   tests/qemu-iotests/128 | 6 ++++++
>   1 file changed, 6 insertions(+)
> 
> diff --git a/tests/qemu-iotests/128 b/tests/qemu-iotests/128
> index d0e00d24b1..d75b1a451a 100755
> --- a/tests/qemu-iotests/128
> +++ b/tests/qemu-iotests/128
> @@ -42,6 +42,12 @@ _setup_eiodev()
>   		echo "0 $((1024 * 1024 * 1024 / 512)) error" | \
>   			$cmd dmsetup create "$devname" 2>/dev/null
>   		if [ "$?" -eq 0 ]; then
> +			DEV="/dev/mapper/$devname"
> +			if ! -e $DEV
> +			then
> +				_notrun "Device $DEV not appearing"
> +			fi
> +
>   			sudo="$cmd"
>   			return
>   		fi

Reviewed-by: Thomas Huth <thuth@redhat.com>


