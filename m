Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8FD6FC25B78
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Jun 2024 20:55:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sEEhU-0001Vi-8i; Mon, 03 Jun 2024 16:54:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dg@treblig.org>)
 id 1sEEhR-0001VQ-I8; Mon, 03 Jun 2024 16:54:38 -0400
Received: from mx.treblig.org ([2a00:1098:5b::1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dg@treblig.org>)
 id 1sEEhP-0003kQ-Ov; Mon, 03 Jun 2024 16:54:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
 ; s=bytemarkmx;
 h=Content-Type:MIME-Version:Message-ID:Subject:From:Date:From
 :Subject; bh=bf3Q4VEvwj/mOWP9QOR2naUzVaiZxBRGyxhLDJ92NU0=; b=hx+9GB4p5IDGXEi+
 nd0IhJd1PhYPisRTDoieZrg6DQPbmAB1uuxRbrIup3onrC//pnTYX2XRN4dJHQmMIqnUV3KsUjx02
 pYwRZFcT7BCuAcDiyXaTi9LcVmPMy39cxe/FWlDBMCeAf8AzkUAEN7aoYsNb270kO2JDdYMzJa9fy
 RMggQvfo2xd0gagiAVEgxuBl7TmQLecrV5zbTHOE6rv8gYjtvcIQurzGjRwbW+FFYBqkpmXJGbjEE
 R11rVGY+IcIiG/PxfRyg9FK/ekRPqU0v92bjWUszYDm9FskCo+QIpaTH5HSdGnt53EiyeClSr7zDv
 G45RUMzwOO+f5RSnCQ==;
Received: from dg by mx.treblig.org with local (Exim 4.96)
 (envelope-from <dg@treblig.org>) id 1sEEhE-0041ci-15;
 Mon, 03 Jun 2024 20:54:24 +0000
Date: Mon, 3 Jun 2024 20:54:24 +0000
From: "Dr. David Alan Gilbert" <dave@treblig.org>
To: Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>
Cc: Thomas Huth <thuth@redhat.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org, Cornelia Huck <cohuck@redhat.com>,
 David Hildenbrand <david@redhat.com>,
 Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 qemu-s390x@nongnu.org, devel@lists.libvirt.org,
 Eric Farman <farman@linux.ibm.com>, Ilya Leoshkevich <iii@linux.ibm.com>,
 Markus Armbruster <armbru@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eric Blake <eblake@redhat.com>, Halil Pasic <pasic@linux.ibm.com>,
 Anton Johansson <anjo@rev.ng>, qemu-arm <qemu-arm@nongnu.org>
Subject: Re: [PATCH 0/4] hw/s390x: Alias @dump-skeys -> @dump-s390-skey and
 deprecate
Message-ID: <Zl4tgFuAdjU2bst6@gallifrey>
References: <20240530074544.25444-1-philmd@linaro.org>
 <cb4028fc-9596-47f3-9468-f8912dd48aed@redhat.com>
 <Zl20rAjHLJlZkwxE@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Zl20rAjHLJlZkwxE@redhat.com>
X-Chocolate: 70 percent or better cocoa solids preferably
X-Operating-System: Linux/6.1.0-21-amd64 (x86_64)
X-Uptime: 20:53:35 up 26 days, 8:07, 1 user, load average: 0.00, 0.00, 0.00
User-Agent: Mutt/2.2.12 (2023-09-09)
Received-SPF: pass client-ip=2a00:1098:5b::1; envelope-from=dg@treblig.org;
 helo=mx.treblig.org
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

* Daniel P. Berrangé (berrange@redhat.com) wrote:
> On Fri, May 31, 2024 at 06:47:45AM +0200, Thomas Huth wrote:
> > On 30/05/2024 09.45, Philippe Mathieu-Daudé wrote:
> > > We are trying to unify all qemu-system-FOO to a single binary.
> > > In order to do that we need to remove QAPI target specific code.
> > > 
> > > @dump-skeys is only available on qemu-system-s390x. This series
> > > rename it as @dump-s390-skey, making it available on other
> > > binaries. We take care of backward compatibility via deprecation.
> > > 
> > > Philippe Mathieu-Daudé (4):
> > >    hw/s390x: Introduce the @dump-s390-skeys QMP command
> > >    hw/s390x: Introduce the 'dump_s390_skeys' HMP command
> > >    hw/s390x: Deprecate the HMP 'dump_skeys' command
> > >    hw/s390x: Deprecate the QMP @dump-skeys command
> > 
> > Why do we have to rename the command? Just for the sake of it? I think
> > renaming HMP commands is maybe ok, but breaking the API in QMP is something
> > you should consider twice.
> 
> That was going to be my question too. Seems like its possible to simply
> stub out the existing command for other targets.

Are these commands really supposed to be stable, or are they just debug
commands?  If they are debug, then add the x- and don't worry too much.

Dave

> The renaming is just window dressing.
> 
> > 
> > And even if we decide to rename ... maybe we should discuss whether it makes
> > sense to come up with a generic command instead: As far as I know, ARM also
> > has something similar, called MTE. Maybe we also want to dump MTE keys one
> > day? So the new command should maybe be called "dump-memory-keys" instead?
> > Or should it maybe rather be an option to the existing "dump-guest-memory"
> > command instead?
> 
> With regards,
> Daniel
> -- 
> |: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
> |: https://libvirt.org         -o-            https://fstop138.berrange.com :|
> |: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
> 
-- 
 -----Open up your eyes, open up your mind, open up your code -------   
/ Dr. David Alan Gilbert    |       Running GNU/Linux       | Happy  \ 
\        dave @ treblig.org |                               | In Hex /
 \ _________________________|_____ http://www.treblig.org   |_______/

