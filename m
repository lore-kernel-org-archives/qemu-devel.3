Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D222BCD343B
	for <qemu-devel@archiver.kernel.org>; Thu,  7 May 2026 06:35:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wKsJh-0007kF-9n; Thu, 07 May 2026 02:34:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1wKsJf-0007jx-SY
 for qemu-devel@nongnu.org; Thu, 07 May 2026 02:34:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1wKsJd-0003xI-Dz
 for qemu-devel@nongnu.org; Thu, 07 May 2026 02:34:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1778135670;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=lKUOH2vJJzWLXh6vmsi7pj9lasVmwc8qfGe5IdhUHpA=;
 b=CB7dqfmExV+5mivMvm8qECfYD/27iKu4zNvaGpVpc06XelSYwDGAA3PGs86d0EezuZMriz
 H9BJ4jLhRWkGkUddY6MxVMs/I2J6LLDJKfFg8wzQATPM3mq/zR5I0lR10VJofR5/NMabF1
 T9N62839efOJBILvcd0hDrLCJmQB7dY=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-301-k0dvXxPGOBeqsEGc0Vb1eQ-1; Thu, 07 May 2026 02:34:29 -0400
X-MC-Unique: k0dvXxPGOBeqsEGc0Vb1eQ-1
X-Mimecast-MFC-AGG-ID: k0dvXxPGOBeqsEGc0Vb1eQ_1778135668
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-43d789cebcfso1153965f8f.1
 for <qemu-devel@nongnu.org>; Wed, 06 May 2026 23:34:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1778135668; x=1778740468; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=lKUOH2vJJzWLXh6vmsi7pj9lasVmwc8qfGe5IdhUHpA=;
 b=H0NSeXg2QY0XrRwPqN/kpife6Wu6AIiX50uUCo5UM958dYfa8S9WslXYbfFG27y4Pp
 gIt1spVuZ3wYFFJGb3J5nlaroZoO9S4vyZYRTBvDCJdcoedpiUQTek6fkEbfXWkQgaoL
 8A9XVQikWFCFX/2tMV2hjMhWZhu93bpqcUEP2i4DhWuIbnENsJE0AKZa0on+vGMa3odN
 traGg3rbM6XRKNB+mWTxInTcDRUKSJgQcAubJs1ECO0149kgaLecvE8BFJ6jZgLk7f8h
 QdhYIGQhzkXgW99LeD94pzirTngFca5z6L+9nqO2b6xaHzDP09xib2cr2IO1+So/cLJP
 52iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778135668; x=1778740468;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lKUOH2vJJzWLXh6vmsi7pj9lasVmwc8qfGe5IdhUHpA=;
 b=US5arWjd+L7IvNq3v741zPPY/a+KH3mGjG263RoUCUkStDZ0llh/S99Lw1OB2oTfSj
 pb9ENpY0OJz8KvTTs7xRb1qkm8O6hWKkUr/1eGN7EOCUVMWvJv325rmw0uAT0+4fHrWd
 rfuqajQK5v2CZoB0X2uTS66qwoSr/fXtaZTpK860+jmqO7htzIf9Ts+k4fmwnRrY35dX
 18DttqTXcUJILHfwSi6HbrEC0Hp0XiI/FAygAx5mA02ZdkCjm9lrDtP63aqm7l7zfxyD
 8/rEsX2sXOCoJgTguVoaW8y/BYf5njfYEK3iasNvaM7JEZujeLy7coZtqIS5a0ZC1KvG
 dqRw==
X-Gm-Message-State: AOJu0Ywk483/Rf/XCEq5N8RvQ6Si6BpE3904J/2xaOs+B0efQpm65ajr
 XD/KneTT2WgJOd/GEEF8WDIF1sPJnXDqR9E7tQCGJbkHuHKdQ0uO8juaf28Q/KeUMB/BwKQeGmk
 TaEM3PcG2F472sk8EQ5JZh0tDsSzROqcEUJQlSaj23wubgYd7gUgZYlWu
X-Gm-Gg: AeBDievM6BFXPZlMnUGcENIjg721/Kc1RuGdTDA2aWym+XJax2aZTaUe+vnYWbzQg7j
 Lvp30T9aqPKmgv5c7/7v9giA6P4rV0YPKFhGAxQhZm/DrHBVIJ4s/jBMSw/ApANRcp70Zh8MAUq
 +cXnIUgJ076APQGLgMSsGT42BJOMM8dEtWOFsVKZBWQw8IlfTNvU2vQhQf+PV8Rl9alq2hM4uO7
 O32ctqzncXVPLg3Iipkm3I1Es79AUKJlD9yexBJ9HuFz3woM60TICA3CYe7zSvqTr1+ypnYkpgo
 4oO8LR1iW59sSQoP8YvqMTJMNTZ0TGdjlu5NJ9CE1flX+xQIU0cYbNdoPB2njrMvaz4XtKzS4Yq
 UUGChqKhUoUmvuew6SQLnkCxMjiat2w==
X-Received: by 2002:a05:600c:3e10:b0:485:3cef:d6ea with SMTP id
 5b1f17b1804b1-48e5e0089e0mr22513915e9.13.1778135667849; 
 Wed, 06 May 2026 23:34:27 -0700 (PDT)
X-Received: by 2002:a05:600c:3e10:b0:485:3cef:d6ea with SMTP id
 5b1f17b1804b1-48e5e0089e0mr22513415e9.13.1778135667520; 
 Wed, 06 May 2026 23:34:27 -0700 (PDT)
Received: from [192.168.0.9] ([47.64.115.164])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48e538a50d0sm171242295e9.5.2026.05.06.23.34.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 06 May 2026 23:34:26 -0700 (PDT)
Message-ID: <3f075602-6814-4ffe-b6e3-b690e6e946fd@redhat.com>
Date: Thu, 7 May 2026 08:34:25 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] update-linux-headers.sh: add typelimits.h to portable
 header list
To: Song Gao <gaosong@loongson.cn>, cohuck@redhat.com, mst@redhat.com
Cc: qemu-devel@nongnu.org, lixianglai@loongson.cn, chenhuacai@loongson.cn,
 clg@redhat.com, pbonzini@redhat.com, peter.maydell@linaro.org,
 richard.henderson@linaro.org, philmd@linaro.org, maobibo@loongson.cn
References: <20260427070029.1059386-1-gaosong@loongson.cn>
 <20260427070029.1059386-2-gaosong@loongson.cn>
Content-Language: en-US
From: Thomas Huth <thuth@redhat.com>
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20260427070029.1059386-2-gaosong@loongson.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.443,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On 27/04/2026 09.00, Song Gao wrote:
> Linux kernel introduced a new UAPI header file typelimits.h in the 7.1
> development cycle (commit merged in Jan 2026). This file is required by
> ethtool.h and other headers that include it.
> 
> Since QEMU's update script only copies headers explicitly listed in the
> for loop, typelimits.h was missing after updating to newer kernel
> versions, causing compilation errors like:
> 
>    fatal error: standard-headers/linux/typelimits.h: No such file or directory
> 
> Add typelimits.h to the list of headers processed by cp_portable() to
> ensure it is properly copied and sanitized into the QEMU source tree
> 
> Cc: clg@redhat.com
> Cc: pbonzini@redhat.com
> Cc: cohuck@redhat.com
> Cc: thuth@redhat.com
> Cc: mst@redhat.com
> Cc: peter.maydell@linaro.org
> Cc: richard.henderson@linaro.org
> Cc: philmd@linaro.org
> Signed-off-by: Song Gao <gaosong@loongson.cn>
> ---
>   scripts/update-linux-headers.sh | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/scripts/update-linux-headers.sh b/scripts/update-linux-headers.sh
> index 386d7a38e7..471f9cc71e 100755
> --- a/scripts/update-linux-headers.sh
> +++ b/scripts/update-linux-headers.sh
> @@ -255,6 +255,7 @@ for i in "$hdrdir"/include/linux/*virtio*.h \
>            "$hdrdir/include/linux/vhost_types.h" \
>            "$hdrdir/include/linux/vmclock-abi.h" \
>            "$hdrdir/include/linux/nitro_enclaves.h" \
> +         "$hdrdir/include/linux/typelimits.h" \
>            "$hdrdir/include/linux/sysinfo.h"; do
>       cp_portable "$i" "$output/include/standard-headers/linux"
>   done

Reviewed-by: Thomas Huth <thuth@redhat.com>


