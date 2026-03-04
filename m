Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8334EB7ED4
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Mar 2026 11:39:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vxkZL-0004TM-6x; Wed, 04 Mar 2026 06:39:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <qemu_oss@crudebyte.com>)
 id 1vxkZJ-0004T0-To
 for qemu-devel@nongnu.org; Wed, 04 Mar 2026 06:39:09 -0500
Received: from kylie.crudebyte.com ([5.189.157.229])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <qemu_oss@crudebyte.com>)
 id 1vxkZI-0005ux-Ax
 for qemu-devel@nongnu.org; Wed, 04 Mar 2026 06:39:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=crudebyte.com; s=kylie; h=Content-Type:Content-Transfer-Encoding:
 MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
 Content-ID:Content-Description;
 bh=YxQflQZuUJ0j2C/tUEp3y776nvrDeIYLNtF3glw8bWA=; b=SQ16Pp8yA26b84j2jQBrX67DZR
 2XOULKWOZRs0rq7HaIzYBV1gMi392dvX6h1rI/ewSH/T8y8bzVYUaLJ1Y6oEct/cmUsubWBELG0fE
 Wnwrvb8R/AJs9FUlFjsESFJGhtPKdoXSmKhfbAazVKhtEBteP16DxHcb1FUhAl7q/JW58S24yIVov
 ippZNigPRqex3t4YbPoVgU2aFgRTy/GgIrncF64fOKjl7nMeHO8rD0a/btlKbOkmeA0kEg93094tu
 Qr7IjbXaqrGhSCf14p+99ImjNh8C0UbRpOLIv2p65nBPSJec1ANvDgLRDUecdY2/d4Vn9hl8wT0wV
 bEa39fznK1R0YTuGTevXdf9CpsnkSAtpuiGMw/M73hfvPyxMctd/WrQ3Xim8IOhuw8/hAQoCmtS+b
 BTmRgjK14Ga/G6cc0NJZLfQe2LT9WqG/7heq4u27pp+juZUBoz7QhzATuAk2dUphy27wNc1cvHApD
 IizEV4BbU328G3cCJ1le8qblLYwurkMRDWKyrKdIXT2xyZbQ38P85nkNScKXbQHJBqD2Itju/A7xp
 Te3AcjCXpqgcaZL4vGNNQWzs+Pib9OtCNXv2pIg5KJ73cGNhJwzrDKMKgo3JYwUtwlyY8y8fwr7oR
 Cqq81iedZie05mzB+OaeI6l5GecgdEZIeKn0D1JPQ=;
From: Christian Schoenebeck <qemu_oss@crudebyte.com>
To: Gerd Hoffmann <kraxel@redhat.com>,
 Philippe =?UTF-8?B?TWF0aGlldS1EYXVkw6k=?= <philmd@linaro.org>,
 BALATON Zoltan <balaton@eik.bme.hu>, qemu-devel@nongnu.org
Cc: qemu-devel@nongnu.org, devel@daynix.com,
 =?UTF-8?B?TWFyYy1BbmRyw6k=?= Lureau <marcandre.lureau@redhat.com>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Subject: Re: [PATCH v8 6/6] coreaudio: Initialize the buffer for device change
Date: Wed, 04 Mar 2026 12:39:02 +0100
Message-ID: <1921566.atdPhlSkOF@weasel>
In-Reply-To: <20260304-coreaudio-v8-6-bf1d40731e73@rsg.ci.i.u-tokyo.ac.jp>
References: <20260304-coreaudio-v8-0-bf1d40731e73@rsg.ci.i.u-tokyo.ac.jp>
 <20260304-coreaudio-v8-6-bf1d40731e73@rsg.ci.i.u-tokyo.ac.jp>
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

On Wednesday, 4 March 2026 07:16:59 CET Akihiko Odaki wrote:
> Reallocate buffers when the active device change as the required buffer
> size may differ.
> 
> Signed-off-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
> Reviewed-by: Phil Dennis-Jordan <phil@philjordan.eu>
> Acked-by: Christian Schoenebeck <qemu_oss@crudebyte.com>
> ---
>  audio/coreaudio.m | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/audio/coreaudio.m b/audio/coreaudio.m
> index 23c3d1f80ac5..e4ec1df971c8 100644
> --- a/audio/coreaudio.m
> +++ b/audio/coreaudio.m
> @@ -471,6 +471,7 @@ static OSStatus init_out_device(CoreaudioVoiceOut *core)
> core->device_id = device_id;
>      core->device_frame_size = device_frame_size;
>      core->hw.samples = core->buffer_count * core->device_frame_size;
> +    audio_generic_initialize_buffer_out(&core->hw);
>      core->ioprocid = ioprocid;
> 
>      return 0;

There is no specific reason to insert that call between the struct
initializers here, or is there? I mean the device is suspended at this point,
so it should not matter. Just looks a bit weird.

But in general, LGTM:

Reviewed-by: Christian Schoenebeck <qemu_oss@crudebyte.com>




