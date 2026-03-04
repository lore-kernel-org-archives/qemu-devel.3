Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27360EB7EB8
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Mar 2026 11:18:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vxkEG-00084h-HI; Wed, 04 Mar 2026 06:17:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <qemu_oss@crudebyte.com>)
 id 1vxkEE-00084V-D6
 for qemu-devel@nongnu.org; Wed, 04 Mar 2026 06:17:22 -0500
Received: from kylie.crudebyte.com ([5.189.157.229])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <qemu_oss@crudebyte.com>)
 id 1vxkEC-0008GN-SF
 for qemu-devel@nongnu.org; Wed, 04 Mar 2026 06:17:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=crudebyte.com; s=kylie; h=Content-Type:Content-Transfer-Encoding:
 MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
 Content-ID:Content-Description;
 bh=kR2yzKLtDRXmaYvCxMIUxe9fQ5w4TqH6p0NCpb8Qhlg=; b=Bt+SSBtRSV9hzRr5mUfZyZnIKs
 yLizPeOeg/le9cbyc0bdmCTGUXiUVbb4P6Nqj21FsamVnj5brVKknbDBQ/EJh06aaQIPTnk657u9D
 8PIeoow3lzf1XyycH39413ZYRXqs+YVGrJAlvdUJXlOPq2eObDR2pV9AjlMg6M1H3TviLqF81ys+Q
 DjilPqwMoA4O1z8lU6rewz2lKA5b025udfZgn2NpEyUJM8MpOYgI7wXKo4vD7nhmtDsVx+lswucPc
 8ZffIbUIXxKSTPZ1Hg+SV1WDFmz8PLeH5Dsm9ZYt6UvXQRvDrlH5kJfGeL9aZUB6CXSD4yAiAF6J/
 p7k0QTg7inezcPlnfQfriNXrTbfcfW0QGuUUDceDvxfOX5BpA6oZtvny/8Q9z6xvG083FUHsSLem8
 AKiq6mGvC+1hXA7GWkj2qxbJaQ2rfXXrMp3TKYQ4H1zeTOkyQXWeJ9zS+GoCwZ0Ck2Rb2qH+NC5Qh
 2v8tW+ws2vt/DBndEzuwdsoEcoHfODLhObHFAzf7WPe1ANPHoIT2tlF0lbhZBfY7y/L1DgLdUePME
 B3Gsjf1Bu/HU01PZQ1nJG3qauCJ5sJ5blQtGua4uWYQCsRnPpdRsVMLP7337+ksjt6qL44PsY3Xee
 q/7UrqIZ2Osw+Uxnwl0bnkvyScatZsf4gBTFEZiNQ=;
From: Christian Schoenebeck <qemu_oss@crudebyte.com>
To: Gerd Hoffmann <kraxel@redhat.com>,
 Philippe =?UTF-8?B?TWF0aGlldS1EYXVkw6k=?= <philmd@linaro.org>,
 BALATON Zoltan <balaton@eik.bme.hu>, qemu-devel@nongnu.org
Cc: devel@daynix.com,
 =?UTF-8?B?TWFyYy1BbmRyw6k=?= Lureau <marcandre.lureau@redhat.com>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Subject: Re: [PATCH v8 5/6] audio: Add functions to initialize buffers
Date: Wed, 04 Mar 2026 12:17:14 +0100
Message-ID: <3742853.R56niFO833@weasel>
In-Reply-To: <8d6f53c2-417a-4e4e-a75e-e0038cfd7f9c@rsg.ci.i.u-tokyo.ac.jp>
References: <20260304-coreaudio-v8-0-bf1d40731e73@rsg.ci.i.u-tokyo.ac.jp>
 <12848166.O9o76ZdvQC@weasel>
 <8d6f53c2-417a-4e4e-a75e-e0038cfd7f9c@rsg.ci.i.u-tokyo.ac.jp>
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

On Wednesday, 4 March 2026 11:47:01 CET Akihiko Odaki wrote:
> On 2026/03/04 17:36, Christian Schoenebeck wrote:
> > On Wednesday, 4 March 2026 07:16:58 CET Akihiko Odaki wrote:
> >> These functions can be used to re-initialize buffers when hardware
> >> parameters change due to device hotplug, for example.
> >> 
> >> Signed-off-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
> >> Reviewed-by: Phil Dennis-Jordan <phil@philjordan.eu>
> >> Reviewed-by: Christian Schoenebeck <qemu_oss@crudebyte.com>
> >> ---
[...]
> >> 
> >> +void audio_generic_initialize_buffer_in(HWVoiceIn *hw)
> >> +{
> >> +    g_free(hw->buf_emul);
> >> +    hw->size_emul = hw->samples * hw->info.bytes_per_frame;
> >> +    hw->buf_emul = g_malloc(hw->size_emul);
> >> +    hw->pos_emul = hw->pending_emul = 0;
> >> +}
> >> +
> >> 
> >>   void audio_generic_run_buffer_in(HWVoiceIn *hw)
> >>   {
> >>   
> >>       AudioMixengBackendClass *k = AUDIO_MIXENG_BACKEND_GET_CLASS(hw->s);
> >>       
> >>       if (unlikely(!hw->buf_emul)) {
> >> 
> >> -        hw->size_emul = hw->samples * hw->info.bytes_per_frame;
> >> -        hw->buf_emul = g_malloc(hw->size_emul);
> >> -        hw->pos_emul = hw->pending_emul = 0;
> >> +        audio_generic_initialize_buffer_in(hw);
> >> 
> >>       }
> > 
> > It would be cleaner having split this patch over 2 patches. One for pure
> > refactoring (no behaviour change), and one that adds g_free(hw->buf_emul);
> 
> g_free() was added because the extracted function can be called with
> hw->buf_emul set. Extracting this into a function without adding
> g_free() makes the function dangerous with non-NULL hw->buf_emul. Adding
> g_free() without extracting it into a function doesn't make sense as it
> checks !hw->buf_emul immediate above.

You are adding the function. So at this point, nobody could have called the
function by accident except you. And as you would have added g_malloc()
immediately with the next patch, there would be no danger.

In general it does make sense splitting pure refactoring from behaviour
changes. And by adding g_free() you are changing existing behaviour. That's
not bike shedding, it's for the sake of being able to skip all those white
noise changes when investigating if something breaks.

And the potential danger argument contradicts itself, because if the function
was called with an uninitialized structure then g_free() would crash. Without
g_free() it was just a potential memory leak OTOH. Choose your poison.

/Christian



