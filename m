Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE1B0C61DB9
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2026 21:09:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wyyOZ-00089h-QP; Tue, 25 Aug 2026 17:09:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mathieu.poirier@linaro.org>)
 id 1wyyOY-000897-Db
 for qemu-devel@nongnu.org; Tue, 25 Aug 2026 17:09:22 -0400
Received: from mail-pj1-x102a.google.com ([2607:f8b0:4864:20::102a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <mathieu.poirier@linaro.org>)
 id 1wyyOW-0008NC-GP
 for qemu-devel@nongnu.org; Tue, 25 Aug 2026 17:09:22 -0400
Received: by mail-pj1-x102a.google.com with SMTP id
 98e67ed59e1d1-38a0c7e841fso492382a91.2
 for <qemu-devel@nongnu.org>; Tue, 25 Aug 2026 14:09:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1787692158; x=1788296958; darn=nongnu.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=XEWwzwm0+KgrrqKho7ClIK9G3IzWKnm2/x3cuuIS4Ro=;
 b=FgWrcXNP2echO/7Bpmafr9VL4p9WQW6AckI+7Znvf+Z1HM8tmnuy0JIJeZjtARh0xP
 QSn4HBH1StlVE3zGJnPrU4YUFVjsbHNQuNE+1UFBZE6RaI3wKCA1azazMUGJsBc4Pfmo
 yqRYKak+SEBshgimzAeY/UQjUqzFbla00MTuekeb9/vibOcfwTuSsaU0NPWZA6/QY550
 6uus//hvlA8XfgTu2JVo1FgC+vQyfp9xM0cuWjlub2VD4Nyax5Zx4qFD+ZGWvVbrpZba
 E96mcOqS4ej6pHJ1v2we/nmEnBPyhzLwnJxNtFw9yhCUZzHQ8CtQZ5ZZPu/ht/92G3TW
 HU4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787692158; x=1788296958;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=XEWwzwm0+KgrrqKho7ClIK9G3IzWKnm2/x3cuuIS4Ro=;
 b=VLuwgAQgrw3JArMl0T39EOLqQHrobAnTDTL9GdV9KqoZ9VKiU+14OV0kzej+7O288y
 gcbixWncmnsalBEwbEDYIvCqN/PFtSyyzp/oQSqFxx8SBfzXYUyzJjHV2RP3H7IDg2XN
 3ixRwhaYLX1wwIcURB913QUVQ42y293ATQ8CLuiVKsr4W1/zGq9ZIZIQmqxEx+754iB2
 yVsZ42qr+eYXggzGCa6SGWHstVYS2Ayu0Z73dnKWzyEj00tsNVZQR3bSdykQQ3tTD9bo
 3mtzNpBoIrPsRVWK7tf6kAMbTseTJZZs8V8YiVLDprHUOeIIsz1JnXMyuG0nny3Aqr7F
 yaYg==
X-Forwarded-Encrypted: i=1;
 AHgh+Rp83Uo6bMsW89a2FmjlT7w/NRHv+3HM+Ucin6nb7mtWf3cAQeAX1mLILAcE5KdXS3h9V9049rsSn0hy@nongnu.org
X-Gm-Message-State: AFuF++mTxEn9cQ2cMzrD8aWfDQxFIpjBubeUAOlkN0vkDPZ9DNeRAMax
 xLqcxoPfRF//iC34D8goF6UirUjrVepMzHEkVUJ0OqOFXCO7GU+cjmjX6KDtUBn7w0U=
X-Gm-Gg: AR+sD12XO8xwG6YM1h33neXu3gw1x5iq2HrZtqvPDZt4mhlfKM9eMDMFZTyNVDmGA5i
 mZIESAfuDY20efAYE/AoXHUMdnL40vFvYHNVXMN0ox78NClOGFzGtbmQR/HEUSg27gMBC/4lqXN
 vxLsEcppd97X5FmI+KN5tsbTCRZN8sTG+O1NQ6cxtnucSYlSPg2PBoRu1bMNo0n80ncGLbjvYpL
 IEfqCNsRGlEAA4BV+sTH0sW22zBA0VJBZTH7uyQs/hq6Cg7vX5b5HdNybtLYpq6P+BWQny/a1qa
 lXSWiQ7y/2/NjoI4hmKvI1RyYPxmyf09S/I1mgBXKXJldDUfoYDcIL1AiNpUvEMZe9mdeR2TGNN
 zgmdb2hWW9r2bPDuwg21E2Vfrp6VBdFZ+v0QQsvoRzpRzMwRTpbE33aKs82LNKFZLBXOXzc4MbQ
 wdhlWZ9r/Bm/Us4OenxBKIwMVWlJTW7TPcRw22jgtX7vRjWtaBED72wKunfnR2sJ1g
X-Received: by 2002:a17:90b:2791:b0:395:7fff:a08f with SMTP id
 98e67ed59e1d1-3966cffb1c7mr4401126a91.0.1787692158304; 
 Tue, 25 Aug 2026 14:09:18 -0700 (PDT)
Received: from p14s ([2604:3d09:148c:c800:a37a:292f:1363:c0af])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-39668a5a55esm1158770a91.16.2026.08.25.14.09.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 25 Aug 2026 14:09:17 -0700 (PDT)
Date: Tue, 25 Aug 2026 15:09:14 -0600
From: Mathieu Poirier <mathieu.poirier@linaro.org>
To: Kohei Enju <enju.kohei@fujitsu.com>
Cc: berrange@redhat.com, kchamart@redhat.com,
 pierrick.bouvier@oss.qualcomm.com, peter.maydell@linaro.org,
 mst@redhat.com, cohuck@redhat.com, pbonzini@redhat.com,
 eblake@redhat.com, armbru@redhat.com, lorenzo.pieralisi@linaro.org,
 gshan@redhat.com, qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 kvm@vger.kernel.org
Subject: Re: [RFC v2 00/24] Add Realm support to QEMU-VMM
Message-ID: <ao4Eetq7oAAsipo4@p14s>
References: <20260728192630.240375-1-mathieu.poirier@linaro.org>
 <amrYWWyWlhnN2Fll@FCCLS0092175.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <amrYWWyWlhnN2Fll@FCCLS0092175.localdomain>
Received-SPF: pass client-ip=2607:f8b0:4864:20::102a;
 envelope-from=mathieu.poirier@linaro.org; helo=mail-pj1-x102a.google.com
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

Hi Kohei - apologies for the delayed reply.

On Thu, Jul 30, 2026 at 02:11:57PM +0900, Kohei Enju wrote:
> On 07/28 13:26, Mathieu Poirier wrote:
> > This patchset provides minimal functionality to start a Realm VM
> > from an Arm RME capable host using the following command line:
> > 
> > qemu-system-aarch64 \
> >  -M confidential-guest-support=rme0 -object rme-guest,id=rme0 \
> >  -cpu host -M virt -enable-kvm -M gic-version=3,its=on -nodefaults ..
> > 
> > It is a refactoring of Jean-Philippe Brucker's initial work dating from a while
> > back.  It is compatible with Steven Price's v14 revision [1] of his work adding
> > CCA support to KVM.
> > 
> > * We are currently working on rebasing the work to v15.
> > 
> > It was tested on the QEMU SBSA machine.  For convenience, a repository is hosted
> > here [2], along with the TF-A [3], RMM [4] and Linux kernel [5] for the SBSA
> > machine (compatible with Steven's v14 patchset).
> > 
> > Instructions to compile and run the entire stack can be found here [6].
> > 
> > Device Assignment is not included.
> > 
> > Thanks,
> > Mathieu
> 
> Hi Mathieu, thank you for your work on upstreaming CCA support. I've
> tested this series in QEMU-TCG(x-rme=on) environments and confirmed
> that the basic functionality works well.
> 
> I have a question about a QMP command for querying CCA capabilities.
> 
> Jean's tree contains the following commit adding such a QMP command. Was
> this functionality intentionally omitted from this series?
> https://git.codelinaro.org/linaro/dcap/qemu/-/commit/41f7852cc8590a38c47299a35a7238da09ff9a12
>

git.codelinaro.org is no longer accessible to me.  Please see if you can point
me to the same patch in this repository:

https://gitlab.com/Linaro/cca-public/qemu/-/commits/cca/2025-09-12?ref_type=heads

 
> We are interested in adding this functionality because we are also
> planning to upstream CCA support for libvirt, which will need a QMP
> interface to query the CCA capabilities exposed by QEMU.
> 
> Since the Linux kernel dropped some configuration parameters such as the
> hash algorithm, I need to rework the implementation of that QMP command
> a bit. If it's okay with you, I'd be happy to send out the reworked
> patch based on this series.
> 
> Thanks,
> Kohei
> 
> > 
> > [1]. https://lore.kernel.org/kvm/20260513131757.116630-1-steven.price@arm.com/T/#m06dd14216aaf76acab65b0a76fb84653141ea64f
> > [2]. https://gitlab.com/Linaro/cca-public/qemu/-/tree/upstream-v2?ref_type=heads
> > [3]. https://gitlab.com/Linaro/cca-public/tf-a/trusted-firmware-a/-/tree/cca/v13?ref_type=heads
> > [4]. https://gitlab.com/Linaro/cca-public/rmm/-/tree/cca/v14?ref_type=heads
> > [5]. https://gitlab.com/Linaro/cca-public/linux/-/tree/upstream-v2?ref_type=heads 
> > [6]. https://gitlab.com/Linaro/cca-public/build-instructions
> > 
> > RFC v1:
> > https://lists.gnu.org/archive/html/qemu-devel/2026-07/msg02307.html
> > 
> > Changes for V2:
> > - Fixed linux headers to include correct bit shift for Realm VM (Gavin).
> > - Removed obsolete rme-guest options (Markus).
> > - Set ConfidentialGuestSupportClass::kvm_init() to kvm_arm_rme_init() (Gavin).
> > - Got rid of kvm_arm_rme_vm_type() (Gavin).
> > - Used kvm_vm_check_extension() instead of kvm_check_extension() to avoid
> >   error message when starting a Realm (Gavin).
> > - Removed obsolete kvm_arm_rme_init_guest_ram() (Gavin).
> > - Collected A-B and R-B.

