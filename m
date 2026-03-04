Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 572FCEB7EA1
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Mar 2026 08:37:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vxhit-0006Hf-RL; Wed, 04 Mar 2026 03:36:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <qemu_oss@crudebyte.com>)
 id 1vxhis-0006HW-M6
 for qemu-devel@nongnu.org; Wed, 04 Mar 2026 03:36:50 -0500
Received: from kylie.crudebyte.com ([5.189.157.229])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <qemu_oss@crudebyte.com>)
 id 1vxhir-0005Oy-58
 for qemu-devel@nongnu.org; Wed, 04 Mar 2026 03:36:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=crudebyte.com; s=kylie; h=Content-Type:Content-Transfer-Encoding:
 MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
 Content-ID:Content-Description;
 bh=j/4Vid9v5Bfx6zU/X59CdsVNRcPVmhSzo/PPCrrmMjw=; b=C1Ju71vaKcmU6yXB9CU/AnKN+X
 azrk/WKX5rtTHuTukxzhNaxyfxSF1nrpyWbwKvb0TFpn+q76hwO0TpHdCo15FistSdd9e+RR6OAmU
 IRwPWA7KAuknHwvgZ9zw8ANiTRrwh5YMh/wL2LNkwvZbNGXRFKMXTyZaGe7LZBsNolsO45FMf0bx9
 0mx1ArJVL2cFEc2ofw9U0zPxlws7uMzFS0m59Ix4OhNxWgMQ4oKh9eprHiNE+N/tBvU48BI0t6R1p
 KaGGdK1Onw7Sr1GZXMGDpjHG4drGp5jrgW3kmuzGpS3f7q3EKdF93l8VLeNdP/1s+88RsEla17pHG
 1BdXbb6ILjip/LDJvrk5LaTZX3gL2QOK+jDi9r+tlRbXmmM2adVUIyiZQGFe7FB6VbnyxAh/8nEfZ
 XbyuU+LowrF1paeWsahSK+kkWv/r0oHpVXb7mAwB8Hs9DrpMCXs4/UOPTQDqQXzf2UZua+tPAkdn2
 7DFOR2VtC+vW0LIzvkw+pumHDx8IL6SJITetOTx+NSVCpExo56EnILQNopipjIm6I0m2fcBaLsUal
 pXWB4YLh3MH/Zzsqu46s+zvrseh/SUmopST9CtNt2ApJx9vbsPt90Rt5PsT+neyz8oPvxhKLz0xY7
 pj7vTUWHSmRDw4WBr64ont81f1Sz1UMQ9W0Y6P/6U=;
From: Christian Schoenebeck <qemu_oss@crudebyte.com>
To: Gerd Hoffmann <kraxel@redhat.com>,
 Philippe =?UTF-8?B?TWF0aGlldS1EYXVkw6k=?= <philmd@linaro.org>,
 BALATON Zoltan <balaton@eik.bme.hu>, qemu-devel@nongnu.org
Cc: qemu-devel@nongnu.org, devel@daynix.com,
 =?UTF-8?B?TWFyYy1BbmRyw6k=?= Lureau <marcandre.lureau@redhat.com>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Subject: Re: [PATCH v8 5/6] audio: Add functions to initialize buffers
Date: Wed, 04 Mar 2026 09:36:42 +0100
Message-ID: <12848166.O9o76ZdvQC@weasel>
In-Reply-To: <20260304-coreaudio-v8-5-bf1d40731e73@rsg.ci.i.u-tokyo.ac.jp>
References: <20260304-coreaudio-v8-0-bf1d40731e73@rsg.ci.i.u-tokyo.ac.jp>
 <20260304-coreaudio-v8-5-bf1d40731e73@rsg.ci.i.u-tokyo.ac.jp>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"
Received-SPF: pass client-ip=5.189.157.229;
 envelope-from=qemu_oss@crudebyte.com; helo=kylie.crudebyte.com
X-Spam_score_int: -5
X-Spam_score: -0.6
X-Spam_bar: /
X-Spam_report: (-0.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.322, RCVD_IN_VALIDITY_SAFE_BLOCKED=1.141,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On Wednesday, 4 March 2026 07:16:58 CET Akihiko Odaki wrote:
> These functions can be used to re-initialize buffers when hardware
> parameters change due to device hotplug, for example.
> 
> Signed-off-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
> Reviewed-by: Phil Dennis-Jordan <phil@philjordan.eu>
> Reviewed-by: Christian Schoenebeck <qemu_oss@crudebyte.com>
> ---
>  audio/audio_int.h       |  2 ++
>  audio/audio-mixeng-be.c | 24 ++++++++++++++++++------
>  2 files changed, 20 insertions(+), 6 deletions(-)
> 
> diff --git a/audio/audio_int.h b/audio/audio_int.h
> index 06f79ade6b0a..290cf373b49f 100644
> --- a/audio/audio_int.h
> +++ b/audio/audio_int.h
> @@ -141,9 +141,11 @@ static inline void *advance(void *p, size_t incr)
>  int wav_start_capture(AudioBackend *state, CaptureState *s, const char
> *path, int freq, int bits, int nchannels);
> 
> +void audio_generic_initialize_buffer_in(HWVoiceIn *hw);
>  void audio_generic_run_buffer_in(HWVoiceIn *hw);
>  void *audio_generic_get_buffer_in(HWVoiceIn *hw, size_t *size);
>  void audio_generic_put_buffer_in(HWVoiceIn *hw, void *buf, size_t size);
> +void audio_generic_initialize_buffer_out(HWVoiceOut *hw);
>  void audio_generic_run_buffer_out(HWVoiceOut *hw);
>  size_t audio_generic_buffer_get_free(HWVoiceOut *hw);
>  void *audio_generic_get_buffer_out(HWVoiceOut *hw, size_t *size);
> diff --git a/audio/audio-mixeng-be.c b/audio/audio-mixeng-be.c
> index 370404505111..1419e7521503 100644
> --- a/audio/audio-mixeng-be.c
> +++ b/audio/audio-mixeng-be.c
> @@ -1187,14 +1187,20 @@ void audio_run(AudioMixengBackend *s, const char
> *msg) }
>  }
> 
> +void audio_generic_initialize_buffer_in(HWVoiceIn *hw)
> +{
> +    g_free(hw->buf_emul);
> +    hw->size_emul = hw->samples * hw->info.bytes_per_frame;
> +    hw->buf_emul = g_malloc(hw->size_emul);
> +    hw->pos_emul = hw->pending_emul = 0;
> +}
> +
>  void audio_generic_run_buffer_in(HWVoiceIn *hw)
>  {
>      AudioMixengBackendClass *k = AUDIO_MIXENG_BACKEND_GET_CLASS(hw->s);
> 
>      if (unlikely(!hw->buf_emul)) {
> -        hw->size_emul = hw->samples * hw->info.bytes_per_frame;
> -        hw->buf_emul = g_malloc(hw->size_emul);
> -        hw->pos_emul = hw->pending_emul = 0;
> +        audio_generic_initialize_buffer_in(hw);
>      }

It would be cleaner having split this patch over 2 patches. One for pure
refactoring (no behaviour change), and one that adds g_free(hw->buf_emul);

>      while (hw->pending_emul < hw->size_emul) {
> @@ -1227,6 +1233,14 @@ void audio_generic_put_buffer_in(HWVoiceIn *hw, void
> *buf, size_t size) hw->pending_emul -= size;
>  }
> 
> +void audio_generic_initialize_buffer_out(HWVoiceOut *hw)
> +{
> +    g_free(hw->buf_emul);
> +    hw->size_emul = hw->samples * hw->info.bytes_per_frame;
> +    hw->buf_emul = g_malloc(hw->size_emul);
> +    hw->pos_emul = hw->pending_emul = 0;
> +}
> +
>  size_t audio_generic_buffer_get_free(HWVoiceOut *hw)
>  {
>      if (hw->buf_emul) {
> @@ -1260,9 +1274,7 @@ void audio_generic_run_buffer_out(HWVoiceOut *hw)
>  void *audio_generic_get_buffer_out(HWVoiceOut *hw, size_t *size)
>  {
>      if (unlikely(!hw->buf_emul)) {
> -        hw->size_emul = hw->samples * hw->info.bytes_per_frame;
> -        hw->buf_emul = g_malloc(hw->size_emul);
> -        hw->pos_emul = hw->pending_emul = 0;
> +        audio_generic_initialize_buffer_out(hw);
>      }
> 
>      *size = MIN(hw->size_emul - hw->pending_emul,





