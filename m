Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0489C02180
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jan 2025 15:32:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tY5Mm-0001Qp-V5; Wed, 15 Jan 2025 10:31:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <qemu_oss@crudebyte.com>)
 id 1tY5Mj-0001Q8-0e
 for qemu-devel@nongnu.org; Wed, 15 Jan 2025 10:31:33 -0500
Received: from kylie.crudebyte.com ([5.189.157.229])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <qemu_oss@crudebyte.com>)
 id 1tY5Mg-0008Di-Vb
 for qemu-devel@nongnu.org; Wed, 15 Jan 2025 10:31:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=crudebyte.com; s=kylie; h=Content-Type:Content-Transfer-Encoding:
 MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
 Content-ID:Content-Description;
 bh=xVFnwv07dEVI0+SZNVT+yxcudKkEEjW5iFWQEbzLOs0=; b=FvcuHFnTq308ZKnMVjTdK0rLF+
 GPnLEBwhzelykfuw+f1eNrZ92A3dQcMjFmTK+lr0oaxSx6piis0TVYsnS4WwqN8Isw+PzFWfgB5tU
 yl8xqOkCnXomxST5k3dEUajsKwuZdTMQgGG/g6E8Sz6yZhVGNkHVGhbj2frFwvrOBHhMak/95ToLq
 vCQKCPwN1hsX6DPBb8oeXyZjf6kc+E8QnHbEfiCxyy0i4Ajz6sNIVojsaw4ou6PurrGbgYZAKwR7L
 Yw4xiNcIJH5BjR00NGn3YZFkuySw62BJkFx1d+rGh2ikVvc2dYqemMhyPcOClZ2DCVmbEY+lSR/Mc
 zHs7TqbQ6tWkcCzglvv3l4tbiGV6B/JIaKzwUo9lxEThIRe8ZW7Y4h3qzSVx/uAegDFy4oCqoL1PA
 rnEGWE/5XNLnzwxD1Q8A/yw8kbgkc4yP3laadkhblIO2yUixun+V2Sy7MeoF8J0JN7xH/h3nvrftl
 X3sgAWhgsWBnC68mr5os+CIBAoasf0KGLZOYARsCzixu1DQri1tNW/SU7o+mBrkNPgDDUfXjG+hBO
 8QGCJWNhKrdwzsMfZT7s+jVY+qbFcKCDROcKDiAqWHPuMsoG105s0kzIn/1I0qiNu0FzsP8I75Kli
 zcX2q2TB1fD7I/31n6yxWlwrUxmS7ull0ii0i/DmA=;
From: Christian Schoenebeck <qemu_oss@crudebyte.com>
To: Gerd Hoffmann <kraxel@redhat.com>,
 Philippe =?ISO-8859-1?Q?Mathieu=2DDaud=E9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, devel@daynix.com,
 Akihiko Odaki <akihiko.odaki@daynix.com>
Subject: Re: [PATCH v3 2/2] coreaudio: Initialize the buffer for device change
Date: Wed, 15 Jan 2025 16:31:27 +0100
Message-ID: <2563327.kqX6A2vZny@silver>
In-Reply-To: <20250115-coreaudio-v3-2-bdb6bcb5bf9f@daynix.com>
References: <20250115-coreaudio-v3-0-bdb6bcb5bf9f@daynix.com>
 <20250115-coreaudio-v3-2-bdb6bcb5bf9f@daynix.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Received-SPF: pass client-ip=5.189.157.229;
 envelope-from=qemu_oss@crudebyte.com; helo=kylie.crudebyte.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Wednesday, January 15, 2025 1:06:56 PM CET Akihiko Odaki wrote:
> Reallocate buffers when the active device change as the required buffer
> size may differ.
> 
> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
> ---
>  audio/audio_int.h |  2 ++
>  audio/audio.c     | 24 ++++++++++++++++++------
>  audio/coreaudio.m |  1 +
>  3 files changed, 21 insertions(+), 6 deletions(-)
> 
> diff --git a/audio/audio_int.h b/audio/audio_int.h
> index 2d079d00a259..9ba4a144d571 100644
> --- a/audio/audio_int.h
> +++ b/audio/audio_int.h
> @@ -187,9 +187,11 @@ struct audio_pcm_ops {
>      void   (*volume_in)(HWVoiceIn *hw, Volume *vol);
>  };
>  
> +void audio_generic_initialize_buffer_in(HWVoiceIn *hw);
>  void audio_generic_run_buffer_in(HWVoiceIn *hw);
>  void *audio_generic_get_buffer_in(HWVoiceIn *hw, size_t *size);
>  void audio_generic_put_buffer_in(HWVoiceIn *hw, void *buf, size_t size);
> +void audio_generic_initialize_buffer_out(HWVoiceOut *hw);
>  void audio_generic_run_buffer_out(HWVoiceOut *hw);
>  size_t audio_generic_buffer_get_free(HWVoiceOut *hw);
>  void *audio_generic_get_buffer_out(HWVoiceOut *hw, size_t *size);
> diff --git a/audio/audio.c b/audio/audio.c
> index 87b4e9b6f2f3..17c6bbd0ae9e 100644
> --- a/audio/audio.c
> +++ b/audio/audio.c
> @@ -1407,12 +1407,18 @@ void audio_run(AudioState *s, const char *msg)
>  #endif
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

Better something like "reinit" in the name maybe?

>  void audio_generic_run_buffer_in(HWVoiceIn *hw)
>  {
>      if (unlikely(!hw->buf_emul)) {
> -        hw->size_emul = hw->samples * hw->info.bytes_per_frame;
> -        hw->buf_emul = g_malloc(hw->size_emul);
> -        hw->pos_emul = hw->pending_emul = 0;
> +        audio_generic_initialize_buffer_in(hw);
>      }
>  
>      while (hw->pending_emul < hw->size_emul) {
> @@ -1446,6 +1452,14 @@ void audio_generic_put_buffer_in(HWVoiceIn *hw, void *buf, size_t size)
>      hw->pending_emul -= size;
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
> @@ -1477,9 +1491,7 @@ void audio_generic_run_buffer_out(HWVoiceOut *hw)
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
> diff --git a/audio/coreaudio.m b/audio/coreaudio.m
> index b9e1a952ed37..72a6df0f75ee 100644
> --- a/audio/coreaudio.m
> +++ b/audio/coreaudio.m
> @@ -466,6 +466,7 @@ static OSStatus init_out_device(coreaudioVoiceOut *core)
>      core->outputDeviceID = deviceID;
>      core->audioDevicePropertyBufferFrameSize = audioDevicePropertyBufferFrameSize;
>      core->hw.samples = core->bufferCount * core->audioDevicePropertyBufferFrameSize;
> +    audio_generic_initialize_buffer_out(&core->hw);
>      core->ioprocid = ioprocid;

I would have probably separated this change into a separate patch, as changes
above were more or less just refactoring, whereas this one changes behaviour.

And like my comment in the previous patch, I wonder whether that call comes
too late. Keep in mind there are e.g. audio devices where you can't change
certain parameters. So not every error here is a fatal error.

>  
>      return 0;



