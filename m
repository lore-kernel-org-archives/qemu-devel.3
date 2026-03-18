Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23C6EFCD0C4
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Mar 2026 13:39:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w2r7T-0006kY-HZ; Wed, 18 Mar 2026 09:39:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dmitry.osipenko@collabora.com>)
 id 1w2r7S-0006kJ-BL
 for qemu-devel@nongnu.org; Wed, 18 Mar 2026 09:39:30 -0400
Received: from sender4-pp-f112.zoho.com ([136.143.188.112])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dmitry.osipenko@collabora.com>)
 id 1w2r7P-0004yo-V8
 for qemu-devel@nongnu.org; Wed, 18 Mar 2026 09:39:29 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1773841159; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=lrVzmWnDpEuQmYDzwGQHCZYqO4lHrExW74EVFIZiaAWzIHiCMkTzLWaSS7S22ySD5NtmqLw+gPI7DfJ9nHOGVWhHIF5C/9AnD45TKGzFdiZ9bBEmXDO1on8T6Ndor7APvQTzD0VXYCd/xMnipfWj5aMe1zHcDzj21DAOMgqNwws=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1773841159;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=jc6dd7llWYJq//D8BTJY731qP3x5zh0HEyDINYFVGgc=; 
 b=MSXoax2Frjay7maIhinHnUHuSLaez7KZb7i4KtR20YhKAAUMC10xFvegW7m/gy4MaV2msmSziCDTX8aIy/AeIEHxR6Ld+CY81G/HXrHscomWP7WDxqJEv18TqRodZZkSdEteXD87++ODWZk+Lzx25gsTMhXAP18Dr7teYrDc9Hg=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=dmitry.osipenko@collabora.com;
 dmarc=pass header.from=<dmitry.osipenko@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1773841159; 
 s=zohomail; d=collabora.com; i=dmitry.osipenko@collabora.com; 
 h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
 bh=jc6dd7llWYJq//D8BTJY731qP3x5zh0HEyDINYFVGgc=;
 b=eIJuAbKxOxYV7iAat1OENmVNiYd3c7XlD2vsXqwM1v0yeQCDTgHB7fGAnaIM2UhC
 15wunLIo+sg+cTgpxDcQ394kkEXM3kE458MSsBSuXvHiHbTxYWdXOAssREYkIPIz6Lz
 lNtLI6Iqm8G8bP+deJqbtUJ3iRstxdmcRtSAl4cg=
Received: by mx.zohomail.com with SMTPS id 1773841156411766.7512417821957;
 Wed, 18 Mar 2026 06:39:16 -0700 (PDT)
Message-ID: <e1bea1d5-5493-456d-ad9c-0c25ae78be30@collabora.com>
Date: Wed, 18 Mar 2026 16:39:13 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] audio/mixeng: fix sw/hw mixup in audio_pcm_sw_init_
To: marcandre.lureau@redhat.com, qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>
References: <20260318084301.653383-1-marcandre.lureau@redhat.com>
From: Dmitry Osipenko <dmitry.osipenko@collabora.com>
Content-Language: en-US
In-Reply-To: <20260318084301.653383-1-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External
Received-SPF: pass client-ip=136.143.188.112;
 envelope-from=dmitry.osipenko@collabora.com; helo=sender4-pp-f112.zoho.com
X-Spam_score_int: -3
X-Spam_score: -0.4
X-Spam_bar: /
X-Spam_report: (-0.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On 3/18/26 11:43, marcandre.lureau@redhat.com wrote:
> From: Marc-André Lureau <marcandre.lureau@redhat.com>
> 
> Commit 42061a14358 ("audio/mixeng: replace redundant pcm_info fields
> with AudioFormat") accidentally changed the conv/clip function selection
> in audio_pcm_sw_init_ to use hw->info.af (the hardware voice format)
> instead of sw->info.af (the software voice format). This causes audio
> distortion when the software and hardware voices use different formats,
> as the wrong conversion functions are applied to the audio data.
> 
> Fix by using sw->info.af, restoring the original behavior.
> 
> Fixes: 42061a14358c ("audio/mixeng: replace redundant pcm_info fields with AudioFormat")
> Reported-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> ---
>  audio/audio_template.h | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/audio/audio_template.h b/audio/audio_template.h
> index 228369cf9a1..f0b2458996a 100644
> --- a/audio/audio_template.h
> +++ b/audio/audio_template.h
> @@ -172,7 +172,7 @@ static int glue (audio_pcm_sw_init_, TYPE) (
>      sw->empty = true;
>  #endif
>  
> -    if (audio_format_is_float(hw->info.af)) {
> +    if (audio_format_is_float(sw->info.af)) {
>  #ifdef DAC
>          sw->conv = mixeng_conv_float[sw->info.nchannels == 2]
>              [sw->info.swap_endianness];
> @@ -187,9 +187,9 @@ static int glue (audio_pcm_sw_init_, TYPE) (
>          sw->clip = mixeng_clip
>  #endif
>              [sw->info.nchannels == 2]
> -            [audio_format_is_signed(hw->info.af)]
> +            [audio_format_is_signed(sw->info.af)]
>              [sw->info.swap_endianness]
> -            [audio_format_to_index(hw->info.af)];
> +            [audio_format_to_index(sw->info.af)];
>      }
>  
>      sw->name = g_strdup (name);

Thanks a lot for the fix!

-- 
Best regards,
Dmitry

