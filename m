Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82C01CCA476
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Oct 2025 15:35:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v7F7U-0007tg-MG; Fri, 10 Oct 2025 11:33:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1v7F7N-0007sr-Ti
 for qemu-devel@nongnu.org; Fri, 10 Oct 2025 11:33:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1v7F7A-0004sF-Er
 for qemu-devel@nongnu.org; Fri, 10 Oct 2025 11:33:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1760110378;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=OR4/WoFgIbevExZmiy6/LmK4RlRFKrcet415a8KG8tk=;
 b=XiEwPE5Mkt/Fg3g2tbRNr8j6sucpy42Mv5HiWbYe5GXUyEh0D/ARDR7LhaOoopXPhXZO9i
 TYxlFwa+JxmN/wdL9vUPmgTCM+pa1xFMnHG/H966Qr89ls2JTET0F5ebhK+K32fXh0biQC
 5LD+tjWrTaUcsDVxTODKHdgpZtaQFkY=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-571-gwNNWRM5MLmwaNwelI_6cA-1; Fri, 10 Oct 2025 11:32:54 -0400
X-MC-Unique: gwNNWRM5MLmwaNwelI_6cA-1
X-Mimecast-MFC-AGG-ID: gwNNWRM5MLmwaNwelI_6cA_1760110374
Received: by mail-qv1-f70.google.com with SMTP id
 6a1803df08f44-78e50889f83so94846516d6.1
 for <qemu-devel@nongnu.org>; Fri, 10 Oct 2025 08:32:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760110374; x=1760715174;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=OR4/WoFgIbevExZmiy6/LmK4RlRFKrcet415a8KG8tk=;
 b=SoAQrqORChg6WaFb3LrU8fwoxgavx8y49AlUev+Udf+2gAwoq+lKTQquK+FPhoBfBM
 3VO2AL1gTKr8YsTh8/xSnoLYTnYwSHE8f+jdCWifBkUgR3H0plKGOA+zCs6tAkrt1r/m
 uVMB6Kqj4tSQgt8ScN+czBE8n/N592DeUhPS1g07G5I/PWV3Y/izqNqrbVk2OzjkOwz5
 RUFkpzNCNXyCAdVibcb7VYiSHtPgKqOZhbLc8UR5jnOmm9iz5Lorc87/MlKEnXVJ7Aze
 X92CEvBxBCevuz/GURxFlVAmTS2k1ashzFMT+qf3Ydsm/DRiNmHW8MFAPM3E7cSr9GPN
 c31g==
X-Forwarded-Encrypted: i=1;
 AJvYcCVfMejirB7ms+hfH3ZPHLmjTIJqmp6/ByQm3mSk8QM9aCUqfMkoNcw7J3jNn5oiqj4OZpPrEM4i4VUa@nongnu.org
X-Gm-Message-State: AOJu0Yz6ENLKgowX7mrnjTPL6UkTdkePSnBj/yYT/+ewiiRcVKcfTbHa
 28pSUTJBhR4Xk7l5tZ/zVrRuGXR4bN+hRlgGUbF73862SP/GCRBxH5wwq+J/X69gnvTVyCQzvjI
 i3P9Zvjxbfyd9v/KgNXbdaNAjUazCaDPqLQ7B/sPuj1nM0mt4R29jrMdu
X-Gm-Gg: ASbGncsjmtSD6Yih0Iu1Tw4aIVfpzeNXh3hRqI5UAtWpxu+uVnx7ZojDMxN8fcmYtcA
 8rYMIseiZIypwsNIJe61s4/Q0bmO/3D0cmiwp6to4xrVyzeHn46VrJ8s10IO5I9rMMb/0v/Cqp7
 dUNGV6tzk0l+RV8jGK091vc0PdVpAt5r0FJcX8MIuSpGmNX3GvUNGcwAXUAxe7fzK9Qrc4hARj5
 Np1FVkwyjMggtLXpUQGB6IVJXBS7b+5vl7KwjTggJhonwanDZHCmx+gk2cc1O8J+oCTrTaCs9io
 oOCfduOrTSRUVmrC6FgtyrD0iia67Bds
X-Received: by 2002:a05:6214:4019:b0:787:3a55:93c2 with SMTP id
 6a1803df08f44-87b2101d84dmr180500016d6.23.1760110372518; 
 Fri, 10 Oct 2025 08:32:52 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IERro9oI8AIkKNF2kUPAyf4bqJP3ILcPJq4Kj32WOrCE6W0qVQobwD85pegKL1+ebZiKGbVKQ==
X-Received: by 2002:a05:6214:4019:b0:787:3a55:93c2 with SMTP id
 6a1803df08f44-87b2101d84dmr180497936d6.23.1760110370614; 
 Fri, 10 Oct 2025 08:32:50 -0700 (PDT)
Received: from x1.local ([142.188.210.50]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-87bc345dee0sm18317736d6.6.2025.10.10.08.32.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Oct 2025 08:32:49 -0700 (PDT)
Date: Fri, 10 Oct 2025 11:32:46 -0400
From: Peter Xu <peterx@redhat.com>
To: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org,
 Alex Williamson <alex.williamson@redhat.com>,
 =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@redhat.com>,
 Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 David Hildenbrand <david@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Helge Deller <deller@gmx.de>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>, John Snow <jsnow@redhat.com>,
 qemu-block@nongnu.org, Keith Busch <kbusch@kernel.org>,
 Klaus Jensen <its@irrelevant.dk>, Jesper Devantier <foss@defmacro.it>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org,
 John Levon <john.levon@nutanix.com>,
 Thanos Makatos <thanos.makatos@nutanix.com>,
 Yanan Wang <wangyanan55@huawei.com>, BALATON Zoltan <balaton@eik.bme.hu>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 David Gibson <david@gibson.dropbear.id.au>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Alexey Kardashevskiy <aik@ozlabs.ru>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Fabiano Rosas <farosas@suse.de>, Thomas Huth <thuth@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Aurelien Jarno <aurelien@aurel32.net>,
 Aleksandar Rikalo <arikalo@gmail.com>, Max Filippov <jcmvbkbc@gmail.com>,
 =?utf-8?B?SGVydsOp?= Poussineau <hpoussin@reactos.org>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Artyom Tarasenko <atar4qemu@gmail.com>
Subject: Re: [PATCH 00/14] Fix memory region use-after-finalization
Message-ID: <aOknHiJRVfe0s_hT@x1.local>
References: <20250917-subregion-v1-0-bef37d9b4f73@rsg.ci.i.u-tokyo.ac.jp>
 <4664fcb7-c747-42dd-966f-6f282abece89@redhat.com>
 <036d19ce-490b-49d2-b114-0b5a91e5e66c@rsg.ci.i.u-tokyo.ac.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <036d19ce-490b-49d2-b114-0b5a91e5e66c@rsg.ci.i.u-tokyo.ac.jp>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.441,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
 T_SPF_TEMPERROR=0.01 autolearn=unavailable autolearn_force=no
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

On Fri, Oct 10, 2025 at 07:20:04PM +0900, Akihiko Odaki wrote:
> On 2025/10/03 0:03, Paolo Bonzini wrote:
> > On 9/17/25 12:32, Akihiko Odaki wrote:
> > > Based-on: <20250917-use-v3-0-72c2a6887c6c@rsg.ci.i.u-tokyo.ac.jp>
> > > ("[PATCH v3 0/7] Do not unparent in instance_finalize()")
> > > 
> > > This patch series was spun off from "[PATCH v2 00/15] Fix memory region
> > > leaks and use-after-finalization":
> > > https://lore.kernel.org/qemu-devel/20250915-use-v2-0-
> > > f4c7ff13bfe9@rsg.ci.i.u-tokyo.ac.jp/
> > > 
> > > When developing the next version of "[PATCH 00/16] memory: Stop
> > > piggybacking on memory region owners*", I faced multiple memory region
> > > leaks and use-after-finalization. This series extracts their fixes so
> > > that the number of Cc: won't explode.
> > > 
> > > Patch "qdev: Automatically delete memory subregions" and the succeeding
> > > patches are for refactoring, but patch "vfio-user: Do not delete the
> > > subregion" does fix use-after-finalization.
> > > 
> > > * https://lore.kernel.org/qemu-devel/20250901-mr-v1-0-
> > > dd7cb6b1480b@rsg.ci.i.u-tokyo.ac.jp/
> > > 
> > > Signed-off-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
> > 
> > This makes sense, but I think it is not bisectable, because of this in
> > memory_region_del_subregion():
> > 
> >      assert(subregion->container == mr);
> >      subregion->container = NULL;
> > 
> > You would need to add a temporary
> > 
> >      if (subregion->container == NULL) {
> >          return;
> >      }
> > 
> > and undo it at the end of the series.  Do you agree?  With this change I
> > can apply it.
> 
> It is unnecessary because patch "qdev: Automatically delete memory
> subregions" satisfies the following:
> 
> 1. the device-specific code can assume that subregions they added are
> present until it finishes unrealization. The unrealize() callback can also
> assume the subregions are present and delete them. qdev satisfies this by
> deleting subregions only after calling the unrealize().
> 
> 2. qdev should delete the remaining subregions before it finishes
> unrealization to ensure that the devices are hidden from the guest. qdev
> satisfies this by checking if memory regions have containers before
> deleting.

There's another option, which is to have the auto-detach patch for qdev
merged, meanwhile we can still keep the "good citizens" who do explicit
detachments in unrealize(), so that it won't confuse the reader on a
specific device about when did the MR went away.  I believe there will be
developers get confused by them otherwise.

The auto detach will only be a final safety belt to make sure MRs won't get
leaked.

If that is an option, it may also explain my original question on what
problem we're fixing... the extreme case is what this series removed
afterwards are exactly all such uses that may need an explicit detachment
of MRs (ignoring there can be owner-shared MR links, which is even out of
the picture).  Then the auto-detach feature may fix nothing, so we merge a
patch, looks good, logically sensible, but not functioning.

The reality might be, we may still have some qdev that should unlink the
MRs in unrealize(), but they didn't.  However again I suspect it's rare,
especially considering the recently merged auto-detach in finalize().  I'd
just go and fix them, but only if they're a real problem (aka,
unpluggable). Then, we know why we introduce a change, and especially, when
the change can go away.

OTOH, if we merge auto-detach of qdev MRs, we likely need to stick it
forever because justifying it not needed will be extremely hard if not
impossible.. after all we do not know what it fixes.  So if we can at least
list the devices that may be fixed with it in the commit message, it would
be a benefit.

Once again, feel free to treat my comment as a pure question.

Thanks,

-- 
Peter Xu


