Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D65E4D339A8
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Oct 2024 17:30:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t5TYe-00008T-JG; Mon, 28 Oct 2024 13:29:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <oliver.upton@linux.dev>)
 id 1t5T3H-0000Nt-1O
 for qemu-devel@nongnu.org; Mon, 28 Oct 2024 12:57:11 -0400
Received: from out-189.mta1.migadu.com ([2001:41d0:203:375::bd])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <oliver.upton@linux.dev>)
 id 1t5T3D-00032M-MY
 for qemu-devel@nongnu.org; Mon, 28 Oct 2024 12:57:10 -0400
Date: Mon, 28 Oct 2024 09:56:51 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
 t=1730134621;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/KOhnqIpYwSqkh+if8TVn48GnX568QbnMCx/zN5PUM4=;
 b=cCvZSEcFd/1XGsQIynCXj1VZLmsOYP6o3327svSfwJaceesyFRqzjIO6goaWG2ST7TPqHO
 8RV5bF238tMqz1xocrZBoQ5YPb4CYfFjXZ0WlGrD50G1L/rUtASS+lTVhayvg+go7wmbgx
 +srcoP8+vCGtfmwRcmYlVuiW7ho49zY=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and
 include these headers.
From: Oliver Upton <oliver.upton@linux.dev>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
 Eric Auger <eric.auger@redhat.com>, eric.auger.pro@gmail.com,
 cohuck@redhat.com, qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 kvmarm@lists.linux.dev, richard.henderson@linaro.org,
 alex.bennee@linaro.org, maz@kernel.org, sebott@redhat.com,
 shameerali.kolothum.thodi@huawei.com, armbru@redhat.com,
 abologna@redhat.com, jdenemar@redhat.com, shahuang@redhat.com,
 mark.rutland@arm.com, philmd@linaro.org, pbonzini@redhat.com
Subject: Re: [RFC 18/21] arm/cpu: Introduce a customizable kvm host cpu model
Message-ID: <Zx_CU9eeQByANMRW@linux.dev>
References: <20241025101959.601048-1-eric.auger@redhat.com>
 <20241025101959.601048-19-eric.auger@redhat.com>
 <ZxuX4i9NjVRizB72@redhat.com>
 <cb6c8f62-c5dc-416d-865f-fbdf96164dac@redhat.com>
 <Zxub7ol4p8P_sWF8@redhat.com>
 <CAFEAcA_wQu17y0PyQwxw0wuf2H5y2VE5aX16nLP2-u7QUP2ggA@mail.gmail.com>
 <Zx-9WxXkmkMuGIlQ@redhat.com>
 <CAFEAcA9w0mb5bcU8p+fScQony-=oqLmNurGWpnL_sBneQCzxUg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAFEAcA9w0mb5bcU8p+fScQony-=oqLmNurGWpnL_sBneQCzxUg@mail.gmail.com>
X-Migadu-Flow: FLOW_OUT
Received-SPF: pass client-ip=2001:41d0:203:375::bd;
 envelope-from=oliver.upton@linux.dev; helo=out-189.mta1.migadu.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Mon, 28 Oct 2024 13:29:26 -0400
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

On Mon, Oct 28, 2024 at 04:48:18PM +0000, Peter Maydell wrote:
> On Mon, 28 Oct 2024 at 16:35, Daniel P. Berrangé <berrange@redhat.com> wrote:
> >
> > On Mon, Oct 28, 2024 at 04:16:31PM +0000, Peter Maydell wrote:
> > > On Fri, 25 Oct 2024 at 14:24, Daniel P. Berrangé <berrange@redhat.com> wrote:
> > > > On Fri, Oct 25, 2024 at 03:18:25PM +0200, Eric Auger wrote:
> > > > > On 10/25/24 15:06, Daniel P. Berrangé wrote:
> > > > > > Also, is this naming convention really the same one that users
> > > > > > will see when they look at /proc/cpuinfo to view features ? It
> > > > > No it is not. I do agree that the custom cpu model is very low level. It
> > > > > is very well suited to test all series turning ID regs as writable but
> > > > > this would require an extra layer that adapts /proc/cpuinfo feature
> > > > > level to this regid/field abstraction.
> > > > >
> > > > > In /cpu/proc you will see somethink like:
> > > > >  Features    : fp asimd evtstrm aes pmull sha1 sha2 crc32 atomics fphp
> > > > > asimdhp cpuid asimdrdm lrcpc dcpop asimddp
> > > >
> > > > Right, IMHO, this is the terminology that QEMU must use in user
> > > > facing APIs.
> > >
> > > /proc/cpuinfo's naming is rather weird for historical
> > > reasons (for instance there is only one FEAT_FP16 feature
> > > but cpuinfo lists "fphp" and "asimdhp" separately).
> >
> > There's plenty of wierd history in x86 too. In this
> > case I might suggest just picking one of the two
> > common names, and ignoring the other.
> >
> > If we really wanted to, we could alias the 2nd name
> > to the first, but its likely not worth the bother.
> 
> Or we could use the standard set of architectural
> feature names, and not have the problem at all, and not
> have to document what we mean by our nonstandard names.

+1

There's existing documentation [*] for the standard feature names, which
provides:

 - A short description of what the feature does
 - Any dependencies a particular feature has (e.g.FEAT_VHE implies
   FEAT_LSE, FEAT_Debugv8p1, and FEAT_AA64EL2)
 - The register fields/values that are used to discover the feature.

This seems like the most user-friendly option...

[*]: https://developer.arm.com/documentation/109697/2024_09

-- 
Thanks,
Oliver

