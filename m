Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E7F2C5DF81
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Aug 2026 13:16:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wx2c0-0005HC-9g; Thu, 20 Aug 2026 09:15:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1wx2by-0005Dr-4k
 for qemu-devel@nongnu.org; Thu, 20 Aug 2026 09:15:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1wx2bw-0000yl-0d
 for qemu-devel@nongnu.org; Thu, 20 Aug 2026 09:15:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1787231709;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=txngaykquXZiq+V+U+/O3Xi4zPZHpCcoMSna6F3gejQ=;
 b=XwA3ALHJuHZgVFVIHCxPBH8ZrQZMMz0w6LFgCWdqt6f4OzmP+rqz5LsbeJY+wlNKinGucP
 0J9e3dC7S5hGZDqm2aMnzidcdiiWrkUL3MZdQy6ByhyhLdZnCuQVe7cb0aNIix0BOJr0p6
 4M/oEQFFV1ogRvEr9E0HFydL4R2f89Q=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-128-x_9ToepnN4mA9_YpjplaBw-1; Thu, 20 Aug 2026 09:15:07 -0400
X-MC-Unique: x_9ToepnN4mA9_YpjplaBw-1
X-Mimecast-MFC-AGG-ID: x_9ToepnN4mA9_YpjplaBw_1787231707
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-47f2de3ba47so1577014f8f.1
 for <qemu-devel@nongnu.org>; Thu, 20 Aug 2026 06:15:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1787231706; x=1787836506; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=txngaykquXZiq+V+U+/O3Xi4zPZHpCcoMSna6F3gejQ=;
 b=VGMaYlikdC9TX1XSabTqlOdMBX/LeyOGsQGIPj+KlP3qKiOUibqVBbhD9n+iaXUUDt
 ztkNfd0GKKtKFIcPf08AxTaxXOTsyWp8zu9Tmhx84/q1jCuK6vd/DNQ6OEWhMSETHrc6
 85Bu7kIUC2ybDV8nijqo53mCwJnf/SmPnm54O4d2534kdqpFOtH1GQCdnDB7w/Q6ad/F
 K1HVDqp4O+DPmY95ZYHXQ7JWs9HA7hHm0JzsBc8mcteFcUNjrB+LdGStfnqVABTADPiF
 EdZQM4yL3Gtr/47j9lfAoYQyXkY/zUABqfXshYS0XLYYERMjscu1J0YYZP6VYFDTPaM6
 NyRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787231706; x=1787836506;
 h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=txngaykquXZiq+V+U+/O3Xi4zPZHpCcoMSna6F3gejQ=;
 b=pmRRRo1X2fnDkG+c5Z3/NLrD58m0D1fHiM1TLlVR467tephv124DbVH4ZHzLq9MAZH
 fGEKg5G3bEsBhi1EYSr2QI+42QsP/c18ZliPTVN4INs30sKwHu8tW1r1PZL6Gywd7IRf
 +OyTVFSwTIb2xb9WwiyiboJKqLQjE32rlcrVR91xP3/qSSKFW52H7Rlot9YSviDUvcve
 kL4QwsFK2naPaDv1Cw00Wc3Az1bMfO1GSBStunk5XdHZ+V54zg/eLUfWS9SJB2qhjb6S
 OaFQiSP72N+CfuX2fshxrhLirS6tvuzooAJhBye3YNKZVEPMcUf7/1L78GOuR83+SI8j
 IetA==
X-Forwarded-Encrypted: i=1;
 AHgh+Rr/aFG33p4g0I3wD4dtb7sqDXKISfjqnaY3dbf1SgnslOkw4gaicjoYMKR23MfsHS5OdpkmN51sMj0V@nongnu.org
X-Gm-Message-State: AFuF++kCyWTlCArY6xlvGydxBQZ8NgXmWbe4/P4OxGfx1xeOza2YuHMe
 axyJZo0jYif2r92sxiSLNjaG7a2Z4UVXdd/iGMeP32AStNFDcQ+N1xMDL1XXK4lnQnlM3Hug57m
 qaqPTTPnGtGVrVl885wRdMXR+tosl82SnY/hcBsamkJrcV0B9LfZ8ra3e
X-Gm-Gg: AR+sD11Y6nuJ5EDS/FyOH1LUe2zpMVPi/p3cg9A99RoBt51ga/VVvIgFkJLzSlQMPw6
 9pbUEzshUoWAF5zbVcriAPQjF4ixPeV3YGhlEK51wyu0XR0IjXBnPk86jiaxD5hZm55TYBeN06f
 UASJgm8MDGZ1/gIiGKTubvHaAv1dxZIiyI6DxctK2iS/EBEWyCqDMPpB6bFpOUwYuSIIr3GZjxW
 Tp5ZCoYghfSKKGvevljjwwyxfH0sHxUZFFK7eIQ1DuAJRktY+uwn+B4zzB2ppSaSc1WUwS5jAe+
 wYFTAXKM+xvQrfBYYakdePbKB2LfkizZfz6uWEoHiGMVGT8rU2H19wEDcGvJm4veE8FIm4k=
X-Received: by 2002:a05:6000:2605:b0:481:4f9b:282b with SMTP id
 ffacd0b85a97d-482b1ff75bcmr22567028f8f.21.1787231706669; 
 Thu, 20 Aug 2026 06:15:06 -0700 (PDT)
X-Received: by 2002:a05:6000:2605:b0:481:4f9b:282b with SMTP id
 ffacd0b85a97d-482b1ff75bcmr22566883f8f.21.1787231706140; 
 Thu, 20 Aug 2026 06:15:06 -0700 (PDT)
Received: from [10.22.3.81] ([91.26.127.10]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-482b14c46f2sm15050607f8f.29.2026.08.20.06.15.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 20 Aug 2026 06:15:05 -0700 (PDT)
Message-ID: <110eb230-f61d-41d2-b498-2792cee37f65@redhat.com>
Date: Thu, 20 Aug 2026 15:15:03 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6/6] docs: deprecate virtio-crypto
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org, "Gonglei (Arei)" <arei.gonglei@huawei.com>
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 zhenwei pi <zhenwei.pi@linux.dev>, "Michael S. Tsirkin" <mst@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>, Laurent Vivier
 <lvivier@redhat.com>, Amit Shah <amit@kernel.org>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, John Snow <jsnow@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 qemu-block@nongnu.org, devel@lists.libvirt.org
References: <20260819-fixes-for-11-2-v1-0-b7981c2cc371@linaro.org>
 <20260819-fixes-for-11-2-v1-6-b7981c2cc371@linaro.org>
Content-Language: en-US
From: Thomas Huth <thuth@redhat.com>
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20260819-fixes-for-11-2-v1-6-b7981c2cc371@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.346,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On 19/08/2026 11.22, Alex Bennée wrote:
> We have outstanding guest exploitable bugs in the code which is fairly
> complex and needs some serious love to clean it up. As off-CPU
> cryptography acceleration seems to be waning in popularity lets just
> deprecate the sub-system with a view to removing it in a couple of
> cycles.
> 
> Link: https://gitlab.com/qemu-project/qemu/-/work_items/3625
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> Cc: Gonglei <arei.gonglei@huawei.com>
> ---
>   docs/about/deprecated.rst | 14 ++++++++++++++
>   1 file changed, 14 insertions(+)
> 
> diff --git a/docs/about/deprecated.rst b/docs/about/deprecated.rst
> index 0c656a968fc..3c22981fc8a 100644
> --- a/docs/about/deprecated.rst
> +++ b/docs/about/deprecated.rst
> @@ -276,6 +276,20 @@ future release. Where no 'dh-params.pem' file is provided, the DH
>   parameters will be automatically negotiated in accordance with
>   RFC7919.
>   
> +Devices
> +-------
> +
> +``virtio-crypto`` (since 11.2)
> +''''''''''''''''''''''''''''''
> +
> +The ``virtio-crypto`` device emulation is quite complex code with a
> +number of known flaws. It has never been migratable so is unlikely to
> +be used in any serious virtualization setting. With most modern
> +systems supporting on-CPU cryptography acceleration via their
> +ISAs sets the need for off-CPU acceleration is also reduced. Add to
> +that the kernel has recently removed the ability to use off-CPU
> +acceleration suggests the time for this sort of off-load has passed.
Reviewed-by: Thomas Huth <thuth@redhat.com>


