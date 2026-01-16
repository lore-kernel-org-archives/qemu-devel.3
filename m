Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C345FD4A607
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Jan 2026 07:17:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vge51-0000Xa-E6; Fri, 16 Jan 2026 02:17:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vge4z-0000WJ-VD
 for qemu-devel@nongnu.org; Fri, 16 Jan 2026 02:17:09 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vge4y-00025A-Ew
 for qemu-devel@nongnu.org; Fri, 16 Jan 2026 02:17:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1768547827;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=wywW2x1u6e4XjfEAtWO+C0MANb0yhDigSBeavZRaSI0=;
 b=KtafRP5dW9m4sxfwRe79wNJqOpIXjUmpYH30/Y68N2C6PsA0MyJN76TvH6gReodF56fRRM
 UuFBB7OPhX674JphoxSlhu0REXN3mI8qQhUbC5uU0NMLmylXdK5UYCz0OJFE87Lvv+Keku
 XwYZihmpPjBxKk36IOrO1fObPCCS5AQ=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-195-fD_DseMlNXKTxYv4Ve55fw-1; Fri, 16 Jan 2026 02:17:04 -0500
X-MC-Unique: fD_DseMlNXKTxYv4Ve55fw-1
X-Mimecast-MFC-AGG-ID: fD_DseMlNXKTxYv4Ve55fw_1768547823
Received: by mail-ed1-f71.google.com with SMTP id
 4fb4d7f45d1cf-64d251b8c5dso1954038a12.1
 for <qemu-devel@nongnu.org>; Thu, 15 Jan 2026 23:17:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1768547823; x=1769152623; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=wywW2x1u6e4XjfEAtWO+C0MANb0yhDigSBeavZRaSI0=;
 b=aXS+O8YJZi7BmlST0YBwhCkL5WmwBNP8s43cQ77uGccSugQPEaTgHWTixkTNE3kXyb
 wyO9+murqREc4beQxVJ99zqxEYLvuIpRtErtbaFiVBXfeLWkKO0R3a5SbqzeUMNdmvyM
 HtwsOJU8opSSF5Ku6lzvOLI2QDo80fOBeS/Fnwi+QejVqPGZU9XHIbwH/xIwHc839Hc+
 GL+JeZ6Y4i4IapWDYP61IM64Nyk4orUIaaJzli7OTeQWNcckmPlaozdOQBNow2VeoZn7
 zDw2JtKn9Q8E2l1dciAEG9HN4ggEH9flADBNXPh3WowNoLxjGQf+vzlBOYNKayHIEft7
 TkVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768547823; x=1769152623;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wywW2x1u6e4XjfEAtWO+C0MANb0yhDigSBeavZRaSI0=;
 b=lwRWV+lihTxgaAJt9T3ekRuuDbt1mVV9FhlVsaTk/VHY5WAc9oRPUexPlbB84WrcDZ
 M1zCJXoYqdjoRo74fOQGOxuOx7gzI3HiGGj70MBoK+YJscG+XHs1Z0XMZCK93kpFJnX2
 dluNFp88dqXfIYl22bQwpIxyk4jMftq2InY88iRgPA8GXCmguhyD0saBelRFPRYG+MIi
 6wfDGOOlI/oMQuyYBZ9q6VQnJh7ZQqO/1vfzLgy3SA2c83Je+ggJAfK17KYk9TKjb5jc
 7qLP7sP+h8bcMMh3ggbh+s3dZ55OSnkXNuz4mA4fDpcGi97tTjcBI+lFlwNz0fyCbG2u
 H5tQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXa3Gdp905lKFs0owgW0Bit34qHo9/ghjNERnuPEe95i52B2o6zt7ThZ7KEC5LHON+jePus839U0kag@nongnu.org
X-Gm-Message-State: AOJu0YyzeD9Fmu6KfTWfUc7zf/wwWmAizc9ToWAxyTTPgMNKKvJXh0/S
 rKgx50RenmP5VM35m1QrxJMtv3b+RbpqRtlam4IR7ZBvKalZYp4QRrajLA60Fnt/OA5BPP5dmc9
 yEMrTZMRlgXQD6GY2THHJ938w2iPZPZxqlslyCzzYeGz2GfGPN2YBlJxp
X-Gm-Gg: AY/fxX7FtiPdcQHyeM0g5x9oPYm7/wyIfW6d97iG3kjDV7DCy8SiiWQj5JadUIV24Uk
 512mYuckOYWfrztaeXTwe7F6zMWfDRt3tFNlKtD6dD9KTboOpo1ak0dmRp+2FGkqWAItIZnkiFp
 0wap3NZrzWtzeSA/FWgqUBcJc+++RV3J6HcBUZfrfFY40mVCzIT56VxbjKx1+xD6Yj6L7foj3VE
 ApZicHw/Twhwb5Lho3SsDVasDwwNANl2ocC6mI3WmwmiN4FPnziJiHKYvmhSU8MIZ6eydTBbd22
 pAcA3oCQaMXViUmuBWIuYlL4GV3NVua1N0xpplN2CPAN7grePnQ3BeAEg1qw83Q0K6PcNmSPBYR
 NBwy5470=
X-Received: by 2002:a05:6402:1467:b0:650:8563:fdc6 with SMTP id
 4fb4d7f45d1cf-65452bcc0f3mr1285870a12.24.1768547823294; 
 Thu, 15 Jan 2026 23:17:03 -0800 (PST)
X-Received: by 2002:a05:6402:1467:b0:650:8563:fdc6 with SMTP id
 4fb4d7f45d1cf-65452bcc0f3mr1285858a12.24.1768547822941; 
 Thu, 15 Jan 2026 23:17:02 -0800 (PST)
Received: from [192.168.0.9] ([47.64.113.220])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-654533cc543sm1543862a12.20.2026.01.15.23.17.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 15 Jan 2026 23:17:02 -0800 (PST)
Message-ID: <88cdd7fb-059b-4ce2-9db6-57700aad0571@redhat.com>
Date: Fri, 16 Jan 2026 08:17:01 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] MAINTAINERS: add maintainer for docs/
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Phil_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Markus Armbruster <armbru@redhat.com>, Stefan Hajnoczi
 <stefanha@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, John Snow <jsnow@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>
References: <20260115203529.2713193-1-pierrick.bouvier@linaro.org>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20260115203529.2713193-1-pierrick.bouvier@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
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

On 15/01/2026 21.35, Pierrick Bouvier wrote:
> I would like to help maintaining qemu documentation and I've been
> invited by Alex to apply as maintainer.
> 
> Files in docs/ that are already maintained will continue to be under
> their respective maintainer. The goal here is to have someone that can
> help on all other files that don't have an official maintainer.
> 
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> ---
>   MAINTAINERS | 5 +++++
>   1 file changed, 5 insertions(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 4ddbfba9f01..786f3b3a456 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -4505,6 +4505,11 @@ Incompatible changes
>   R: devel@lists.libvirt.org
>   F: docs/about/deprecated.rst
>   
> +General Documentation
> +M: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> +S: Maintained
> +F: docs/

You might trigger a lot of traffic to your inbox that way ... but if you 
don't mind:

Acked-by: Thomas Huth <thuth@redhat.com>


