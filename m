Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ACD17CCD1BF
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Oct 2025 07:06:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vBSuK-0005Ld-US; Wed, 22 Oct 2025 03:05:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vBSuB-00050X-IL
 for qemu-devel@nongnu.org; Wed, 22 Oct 2025 03:05:09 -0400
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vBSu8-0000oU-8v
 for qemu-devel@nongnu.org; Wed, 22 Oct 2025 03:05:07 -0400
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-3ece1102998so5313847f8f.2
 for <qemu-devel@nongnu.org>; Wed, 22 Oct 2025 00:05:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761116701; x=1761721501; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=laSEhwk0/2pHmc6nx1AjCtcj9n308ZzbCyOnAEG3CPw=;
 b=X/IBvPgxmWrNgNcpb3Z/+gw6B5XE9eBPrXym6lmgngkCZoeavth6odBvQXSHOpCLRV
 FqwKI5d32Ljrq2KTOBdUkIllgqV16pU/sIjjT6DxHOvxW+V/b3g1mtQ5nWD5iIcqMV22
 SNO0CkuniZ81T9ohR451jVlsp+1zEviD9HsRrZ0q8iiUl7/arVuveFBRsXCTNhh/odvi
 5AMLc9w14pLyxG7sFR1Zsq2Cp9GtUMhl9NCAdtV1a1bJEpA4YpoAww8No2zaf4xqi6YT
 PK5pCmOKp2X44DEQJJfAPShFWQnqLWaIVC/MW2GA2uBDl1Qh5IYjom2lvKlrsiZm/RwT
 8wLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761116701; x=1761721501;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=laSEhwk0/2pHmc6nx1AjCtcj9n308ZzbCyOnAEG3CPw=;
 b=mfEaJTBI76HPTSa3taScUkRKmYo3YM2p/5i2NgsE7WmCYNrRibLs6R3k5GjzyZiVrN
 YLX2wkPt/cNIvvEn+crTQ6BHBeyEXtNU+/9T4+pA3f+1hZNWZpy0sX33XeJEOb9QmkOF
 VGJasru37Q1/w5b7bbna/3RMoMyuQU79/1+M7B8k1N7WUVZHzdNhglfI66XGf54jX8Wn
 Ke24WICIgku9yWSOFdpCr720WskoyauoNUwMmpW6xJqM9EIRySJgsp022YwZcz9iYEpW
 /vqvqoGIInNmURA2wHpA+VOIdZ22L41KfZPMofBOUXyHAAL8fTKjORKgmuGI/2J5EAet
 L0RQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWJum+WqfAd/MeUMfZyQodREkM1Duz3HCtA/Rpolw9eYl3CFNSBWVI4varRsa0ZdaCQrh5BX5ZX7lMh@nongnu.org
X-Gm-Message-State: AOJu0Yw8Brgz9ou5uArRhvDUvHAfW7kkTUQNjgsCoP0/Lk9x+TbvdSxV
 aSw9NUrNdhgxh6ECI8Zix2X1ebHItmTTmOf1sknYBMgi4iGDv6C9nsULDg9/kiXyQqCsHkadu4Y
 CwF9UPDU=
X-Gm-Gg: ASbGncuwacYTygC5diqAjODdoPvgCM73h4WGvZAKY6meJ352xkLaagiP5Nh4PrFPmVV
 JMoV5xuTdSvckO4j9q6fjx3VidEgqUYgx8bL3JzrTa41+bLejvhee/B53oXJCIsM6nIOK+UF82S
 9inmU0x1bwF1PaXi/8fhc61s9gaotGISc0LgYBpz8CF8Coh0lDyA175GOfydpOlMO6Tu8YhRGE9
 mOXeePT3fsWBh/tkFukrKUHVrb6Nbmuy2zym24vEffR8CN4AaQAM7R3o1eSd7EMJOYONSlsf6dL
 vhJ8PnwiHSg0Tt9In0cJrPodAfSx8fwVf7mY42ZvpHzRRoQPmQV8rm99kPLWy+56m1GtvtKoXha
 e1g5TWOofRep+a00HPWJVIn1oIgllKrLcQMka6ERxrWi2Fgx/dQhvbU7Lv0M5TYPPY5/poSz9tb
 QfTKQcDcu5oJccykBxOl4TKwp6hP+DuC+XIc1bAlS5xOZlAMyP3zbJpoNhqGiVuZi6
X-Google-Smtp-Source: AGHT+IFpCpNkIECIdZgp2TwvXqHF6qsyGpAiROiPf6Y06gqhauwgS//i5yzEd1o7wz41QvHYN6NL3g==
X-Received: by 2002:a05:6000:420e:b0:425:72a0:a981 with SMTP id
 ffacd0b85a97d-42704d830aemr11094288f8f.2.1761116701519; 
 Wed, 22 Oct 2025 00:05:01 -0700 (PDT)
Received: from [192.168.69.221] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-427f00ce678sm24051715f8f.51.2025.10.22.00.05.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 22 Oct 2025 00:05:01 -0700 (PDT)
Message-ID: <35fc3048-85de-4f75-a967-f57c8cca58bd@linaro.org>
Date: Wed, 22 Oct 2025 09:05:00 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 39/42] audio: cleanup, use bool for booleans
Content-Language: en-US
To: marcandre.lureau@redhat.com, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Volker_R=C3=BCmelin?= <vr_qemu@t-online.de>,
 Paolo Bonzini <pbonzini@redhat.com>, BALATON Zoltan <balaton@eik.bme.hu>,
 Gerd Hoffmann <kraxel@redhat.com>
References: <20251022065640.1172785-1-marcandre.lureau@redhat.com>
 <20251022065640.1172785-40-marcandre.lureau@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20251022065640.1172785-40-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42e;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 22/10/25 08:56, marcandre.lureau@redhat.com wrote:
> From: Marc-André Lureau <marcandre.lureau@redhat.com>
> 
> Use slightly better types for the job.
> 
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> ---
>   audio/audio_int.h      | 12 ++++++------
>   audio/audio_template.h |  6 +++---
>   include/qemu/audio.h   |  8 ++++----
>   audio/audio.c          | 30 +++++++++++++++---------------
>   4 files changed, 28 insertions(+), 28 deletions(-)


> diff --git a/include/qemu/audio.h b/include/qemu/audio.h
> index 216b95eb4f..f5c32550dc 100644
> --- a/include/qemu/audio.h
> +++ b/include/qemu/audio.h
> @@ -98,8 +98,8 @@ SWVoiceOut *AUD_open_out (
>   void AUD_close_out (AudioBackend *be, SWVoiceOut *sw);
>   size_t AUD_write (SWVoiceOut *sw, void *pcm_buf, size_t size);
>   int  AUD_get_buffer_size_out (SWVoiceOut *sw);
> -void AUD_set_active_out (SWVoiceOut *sw, int on);
> -int  AUD_is_active_out (SWVoiceOut *sw);
> +void AUD_set_active_out (SWVoiceOut *sw, bool on);
> +bool AUD_is_active_out (SWVoiceOut *sw);
>   
>   void     AUD_init_time_stamp_out (SWVoiceOut *sw, QEMUAudioTimeStamp *ts);
>   uint64_t AUD_get_elapsed_usec_out (SWVoiceOut *sw, QEMUAudioTimeStamp *ts);
> @@ -128,8 +128,8 @@ SWVoiceIn *AUD_open_in (
>   
>   void AUD_close_in (AudioBackend *be, SWVoiceIn *sw);
>   size_t AUD_read (SWVoiceIn *sw, void *pcm_buf, size_t size);
> -void AUD_set_active_in (SWVoiceIn *sw, int on);
> -int  AUD_is_active_in (SWVoiceIn *sw);
> +void AUD_set_active_in (SWVoiceIn *sw, bool on);
> +bool AUD_is_active_in (SWVoiceIn *sw);
>   
>   void     AUD_init_time_stamp_in (SWVoiceIn *sw, QEMUAudioTimeStamp *ts);
>   uint64_t AUD_get_elapsed_usec_in (SWVoiceIn *sw, QEMUAudioTimeStamp *ts);
> diff --git a/audio/audio.c b/audio/audio.c
> index 5d3fb799f9..a9df7d73cd 100644
> --- a/audio/audio.c
> +++ b/audio/audio.c
> @@ -405,7 +405,7 @@ static void audio_notify_capture (CaptureVoiceOut *cap, audcnotification_e cmd)
>       }
>   }
>   
> -static void audio_capture_maybe_changed (CaptureVoiceOut *cap, int enabled)
> +static void audio_capture_maybe_changed (CaptureVoiceOut *cap, bool enabled)

Please fix checkpatch.pl errors while modifying these lines, otherwise:
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


