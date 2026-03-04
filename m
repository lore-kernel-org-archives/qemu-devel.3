Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80C2DEB7ED8
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Mar 2026 11:56:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vxkpp-0000Yt-0K; Wed, 04 Mar 2026 06:56:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <qemu_oss@crudebyte.com>)
 id 1vxkpn-0000YM-HK
 for qemu-devel@nongnu.org; Wed, 04 Mar 2026 06:56:11 -0500
Received: from kylie.crudebyte.com ([5.189.157.229])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <qemu_oss@crudebyte.com>)
 id 1vxkpm-0002Om-2H
 for qemu-devel@nongnu.org; Wed, 04 Mar 2026 06:56:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=crudebyte.com; s=kylie; h=Content-Type:Content-Transfer-Encoding:
 MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
 Content-ID:Content-Description;
 bh=6PMrR4E3chN1Jk29FHl0Zg22BWjCvEAUxwgU9bPXgsM=; b=w6TEdSvPowOJxWqOvaJZTYiSYz
 iaseISHePKMYyYdv31aIS2++0skkpNoWypTIP5kgvG/DJ3B91SzVsy4JRgdc1Ag6jgEAZt2SaGSuG
 uRUi7AHzea2VTwvKd8lgsveJHS1DEy/NaG+6986zec7wgPPuwD55MVQHz3JdwndoHfgfEaLIH8UDe
 4NAo7DcqyyaevR5Zv8ETOT47GjoeAiJWjt6vQ2Pqv17aa5g0Ml+sDXwizi3SabQRs4Ltx2hx0XoZc
 uPm6GP5Pf6X7roR4+PFy+8EoOxYT58ySPwNdB4ORTSpEqcqo4YDYCHmKB0BX5klmvQQc3fqb/fMhQ
 8clVaVL7O8R3zGU0MldjSqIXMq1HwZ3zhH7dM9FXjyDyi8eyK/j7AFou/nJmdcSdiiwedEGaTa07O
 a8BTPOcfi0ZnViYocRoQVGRF+sqS9IP7/AAdIBUjRmwgqS4uLfHuM/2qc2L3nCFNM+Pp9iYx89nDr
 r7PUmnGOi3+32DCODf548o4kfJflQ0F6foQWT1K3z6KdbQujE8meT3ARjvnew9NQJg05MrLAbcyTS
 ydrc4Q1AciMeC2vj5SIjLi4oMbbbZtqb1oFPm2Gbed2g71RexRCv87gr9UvkTkiQfRA34rBl6GEIJ
 DB+cW++tmn5VlIxgSzGLQ7w98fC8253qk86QsxOiQ=;
From: Christian Schoenebeck <qemu_oss@crudebyte.com>
To: Gerd Hoffmann <kraxel@redhat.com>,
 Philippe =?UTF-8?B?TWF0aGlldS1EYXVkw6k=?= <philmd@linaro.org>,
 BALATON Zoltan <balaton@eik.bme.hu>, qemu-devel@nongnu.org
Cc: qemu-devel@nongnu.org, devel@daynix.com,
 =?UTF-8?B?TWFyYy1BbmRyw6k=?= Lureau <marcandre.lureau@redhat.com>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Subject: Re: [PATCH v8 4/6] coreaudio: Commit the result of init in the end
Date: Wed, 04 Mar 2026 12:56:04 +0100
Message-ID: <2042987.yKVeVyVuyW@weasel>
In-Reply-To: <20260304-coreaudio-v8-4-bf1d40731e73@rsg.ci.i.u-tokyo.ac.jp>
References: <20260304-coreaudio-v8-0-bf1d40731e73@rsg.ci.i.u-tokyo.ac.jp>
 <20260304-coreaudio-v8-4-bf1d40731e73@rsg.ci.i.u-tokyo.ac.jp>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"
Received-SPF: pass client-ip=5.189.157.229;
 envelope-from=qemu_oss@crudebyte.com; helo=kylie.crudebyte.com
X-Spam_score_int: 0
X-Spam_score: -0.0
X-Spam_bar: /
X-Spam_report: (-0.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.703, RCVD_IN_VALIDITY_SAFE_BLOCKED=1.386,
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

On Wednesday, 4 March 2026 07:16:57 CET Akihiko Odaki wrote:
> init_out_device may only commit some part of the result and leave the
> state inconsistent when it encounters a fatal error or the device gets
> unplugged during the operation, which is expressed by
> kAudioHardwareBadObjectError or kAudioHardwareBadDeviceError. Commit the
> result in the end of the function so that it commits the result iff it
> sees no fatal error and the device remains plugged.
> 
> With this change, handle_voice_change can rely on core->outputDeviceID
> to know whether the output device is initialized after calling
> init_out_device.
> 
> Signed-off-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
> ---
>  audio/coreaudio.m | 47 ++++++++++++++++++++++++++---------------------
>  1 file changed, 26 insertions(+), 21 deletions(-)
> 
> diff --git a/audio/coreaudio.m b/audio/coreaudio.m
> index 736227eb2b7a..23c3d1f80ac5 100644
> --- a/audio/coreaudio.m
> +++ b/audio/coreaudio.m
> @@ -357,8 +357,11 @@ static OSStatus out_device_ioproc(
> 
>  static OSStatus init_out_device(CoreaudioVoiceOut *core)
>  {
> +    AudioDeviceID device_id;
> +    AudioDeviceIOProcID ioprocid;
>      AudioValueRange value_range;
>      OSStatus status;
> +    UInt32 device_frame_size;

Shouldn't then be this here at the beginning?

  core->device_id = kAudioDeviceUnknown;
  core->ioprocid = NULL;
  ...

[...]
>      if (status != kAudioHardwareNoError) {
>          coreaudio_playback_logerr(status,
>                                    "Could not set device buffer frame size %" PRIu32,
> -                                  (uint32_t)core->device_frame_size);
> +                                  (uint32_t)device_frame_size);
>          return status;
>      }

Why the cast here? device_frame_size is declared as UInt32.

/Christian



