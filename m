Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D24CCA5FDD
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Oct 2026 16:33:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xCgBz-0004s0-2h; Fri, 02 Oct 2026 12:33:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1xCgBx-0004rc-5x
 for qemu-devel@nongnu.org; Fri, 02 Oct 2026 12:33:02 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1xCgBv-0006fS-69
 for qemu-devel@nongnu.org; Fri, 02 Oct 2026 12:33:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1790958776;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=K1xrRgMuowtJU/AyL7q9uOj6RF4ZlGCwUh9gu4GUDZ4=;
 b=WHCwmLnGhKuIeTell/Egl/86QggK5dSv0RZaheM1SOTtI/FsRjJ+Efu5N+sqKNxDosDBek
 ff1ON8axuSyqTt25rj7MfaYvfsWJIDbFbC2wXlFKIrivsFjI8vsZXyyw5lMfa7IaSt/HeS
 KmHNB0i3Qbtpvq4HY3JYGZBB+CVjVGU=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-284-r_hgWvEvONea0h5n1yfArA-1; Fri,
 02 Oct 2026 12:32:53 -0400
X-MC-Unique: r_hgWvEvONea0h5n1yfArA-1
X-Mimecast-MFC-AGG-ID: r_hgWvEvONea0h5n1yfArA_1790958770
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 9A1921808875; Fri,  2 Oct 2026 16:32:42 +0000 (UTC)
Received: from redhat.com (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id F0BD01956086; Fri,  2 Oct 2026 16:32:36 +0000 (UTC)
Date: Fri, 2 Oct 2026 17:32:33 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Cc: luoyonggang@gmail.com,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 qemu-devel@nongnu.org, Chao Liu <chao.liu@processmission.com>,
 Eric Blake <eblake@redhat.com>, qemu-arm@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Brian Cain <brian.cain@oss.qualcomm.com>,
 Stafford Horne <shorne@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Fabiano Rosas <farosas@suse.de>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 qemu-riscv@nongnu.org, Laurent Vivier <lvivier@redhat.com>,
 Max Filippov <jcmvbkbc@gmail.com>, Song Gao <17746591750@163.com>,
 Philippe Mathieu-Daude <philmd@mailo.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Laurent Vivier <laurent@vivier.eu>, Weiwei Li <liwei1518@gmail.com>,
 Zhao Liu <zhao1.liu@intel.com>
Subject: Re: [PATCH v3 01/10] machine: allow -M name to differ from QOM type
Message-ID: <ar_coT44h5-zJPVV@redhat.com>
References: <CAE2XoE8q3LYJ-JCTbRBk4iPdUQdRE8zzmOgiZ=HEXDL78iw8UQ@mail.gmail.com>
 <26b0d44d-0322-4ceb-a47b-747fc52c61b7@oss.qualcomm.com>
 <CAE2XoE8VyCpPCqRVFArBn_dDsyMw8vrSJxWMhKq17btZvO2n6A@mail.gmail.com>
 <b02db9e2-b348-4011-a98d-122e9d9f17e5@oss.qualcomm.com>
 <ar6a_uDw9OeLng6c@redhat.com>
 <6bf4dad5-4fa2-4df1-b6b8-d594dbd3842c@oss.qualcomm.com>
 <ar6lw3jAcnVej6vK@redhat.com>
 <557262df-b8e7-49b5-a245-ae46b8885b30@oss.qualcomm.com>
 <CAE2XoE8MriyEEeRF3uDwWgnJWPHBieK_-pD1+k0tUjROWjDpWg@mail.gmail.com>
 <a9cba466-f442-4bbf-9154-3674b5f10882@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a9cba466-f442-4bbf-9154-3674b5f10882@oss.qualcomm.com>
User-Agent: Mutt/2.4.2 (2026-08-30)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.336,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Fri, Oct 02, 2026 at 08:40:54AM -0700, Pierrick Bouvier wrote:
> On 10/1/2026 7:00 PM, Yonggang Luo wrote:
> > On Fri, Oct 2, 2026 at 2:56 AM Pierrick Bouvier
> > <pierrick.bouvier@oss.qualcomm.com> wrote:
> >>
> >> On 10/1/2026 11:26 AM, Daniel P. Berrangé wrote:
> >>> On Thu, Oct 01, 2026 at 11:08:17AM -0700, Pierrick Bouvier wrote:
> >>>> On 10/1/2026 10:40 AM, Daniel P. Berrangé wrote:
> >>>>> Even with the current per-target binaries there are countless
> >>>>> devices linked in which are incompatible / not usable with
> >>>>> certain machine types. A new multi-target binary with a union
> >>>>> of all devices will just be a bigger example of a scenario that
> >>>>> already has to be dealt with for today's binaries.
> >>>>>
> >>>>> So if we have that assumption that we don't need to do device
> >>>>> filtering, at that point, a --target option doesn't have as
> >>>>> big of a role to play. The machine type code knows what target(s)
> >>>>> it wants (1 or 2 targets depending on if there are 32 + 64 bit
> >>>>> varaints. The CPU model the user requests (if the CPU is not
> >>>>> hardcoded by the machine), determines 32 bit vs 64 bit.
> >>>>>
> >>>>
> >>>> How can we deduce this information (bitness or target for existing
> >>>> machines/cpus)?
> >>>
> >>> It would require that we introduce a new field in MachineClass
> >>> that returned that information about what target a machine is
> >>> associated with.
> >>>
> >>> I note the SysEmuTarget covers both 32-bit and 64-bit variants.
> >>>
> >>> It might be better use QEMU_ARCH which correlates directly to
> >>> the TCG targets, rather than the traditional binary target
> >>> names ?
> >>>
> >>> Likely the CPU class would also want to declare its list of
> >>> supported targets.
> >>>
> >>
> >> QEMU_ARCH only represents base architectures, and not variant, so
> >> SysEmuTarget is the right choice.
> >>
> >> So, we would need a list of SysEmuTarget for every cpu/machine that is
> >> target specific, since one could be available for variants of base arch?
> > 
> > For this, adding TargetInfo parameter to is_avaible callback will let us get the
> > list of SysEmuTarget for every cpu/machine. As we can iterate on all TargetInfo
> > then check if that TargetInfo is present for every cpu/machine.
> > And indeed for devices if you want. That's what my patches are already done.
> >
> 
> @Daniel: would that work for you? I feel like it limits the way to
> introspect qom objects, but maybe not if we export the right thing on
> QAPI side based on that.

"is_available" is probably a bit overkill as a mechanism for
introspecting, when we just need to return a list of targets,
Since we have that already we might as well use it initially
though.

> >> Does it matches what you would expect?
> >>
> >> Also, for compatibility with existing binaries, should we accept -M
> >> $arch-virt also? I feel like it does not hurt and would make thing
> >> simpler to switch between existing and new binary.
> > 
> > Same reason -M $arch-virt, indeed like -M $arch:virt,  but $arch-virt
> > would be even harder.
> > Because "-" is a valid separator in machine names, ":" is not a valid
> > machine name.
> > So without init QOM, we can not reliably identify "$arch-virt" belongs
> > to which target.
> >
> 
> From the conversation above, Daniel and I are not in favor to have any
> kind of parsing based on this string. So either we'll pick virt, or the
> real qom name, but not anything else.

Yeah, I'm leaning more towards always exposing the $arch-virt names
in all binaries, and also exposing 'virt' in the traditional
binaries only.


With regards,
Daniel
-- 
|: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
|: https://libvirt.org          ~~          https://entangle-photo.org :|
|: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|


