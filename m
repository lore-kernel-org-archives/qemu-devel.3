Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 969E7C25B75
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Jun 2024 17:08:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sEB95-0001Z8-Ut; Mon, 03 Jun 2024 13:06:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dg@treblig.org>)
 id 1sEB93-0001XJ-MV; Mon, 03 Jun 2024 13:06:53 -0400
Received: from mx.treblig.org ([2a00:1098:5b::1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dg@treblig.org>)
 id 1sEB91-0001uj-7v; Mon, 03 Jun 2024 13:06:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
 ; s=bytemarkmx;
 h=Content-Type:MIME-Version:Message-ID:Subject:From:Date:From
 :Subject; bh=hIhvFG904StDLDEXs02aTwGPPyUmkI3bpXgRnoN+kU8=; b=ELrkcLY/6EwMu8Ty
 Eb52QEPH5cfiek1zT/RZ45JAm4u/p/wvFE03eS1QtjWA5U7XsdGL+Qj7NNtHTMIe6xIy3983dXjsP
 v9jrevej3+AhJB0GTLi56AKUomd61zdrltr4a0PoKtybCt5Bwgfuu0YnYJBjGkD0CyXByGoq7Br+V
 icQiRkgjJ3L83iOhXz9yEws9cPVdu7i3F8gP6yHLqAPYdSYNVrE5k/mAim1pLkpyPWP8tsQGhZusZ
 F9xH9DV3JwgZv9L4cGqoeWkb5t9p7OdcPoSVqELZnMiav/Y3U4Phrrfd06t7f/qa83kI5k/Iz8DS2
 X1fVlrzKuDNGJXQGPQ==;
Received: from dg by mx.treblig.org with local (Exim 4.96)
 (envelope-from <dg@treblig.org>) id 1sEB8o-003zgA-1o;
 Mon, 03 Jun 2024 17:06:38 +0000
Date: Mon, 3 Jun 2024 17:06:38 +0000
From: "Dr. David Alan Gilbert" <dave@treblig.org>
To: Thomas Huth <thuth@redhat.com>
Cc: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org, Cornelia Huck <cohuck@redhat.com>,
 David Hildenbrand <david@redhat.com>,
 Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
 qemu-s390x@nongnu.org, devel@lists.libvirt.org,
 Eric Farman <farman@linux.ibm.com>, Ilya Leoshkevich <iii@linux.ibm.com>,
 Markus Armbruster <armbru@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eric Blake <eblake@redhat.com>, Halil Pasic <pasic@linux.ibm.com>,
 Anton Johansson <anjo@rev.ng>, qemu-arm <qemu-arm@nongnu.org>
Subject: Re: [PATCH 0/4] hw/s390x: Alias @dump-skeys -> @dump-s390-skey and
 deprecate
Message-ID: <Zl34HkNkeWnVhssP@gallifrey>
References: <20240530074544.25444-1-philmd@linaro.org>
 <cb4028fc-9596-47f3-9468-f8912dd48aed@redhat.com>
 <ZlnYkt9sLgDbQqVT@gallifrey>
 <6fec1c49-c6a6-4e96-bc44-5dc7feb843e6@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <6fec1c49-c6a6-4e96-bc44-5dc7feb843e6@redhat.com>
X-Chocolate: 70 percent or better cocoa solids preferably
X-Operating-System: Linux/6.1.0-21-amd64 (x86_64)
X-Uptime: 17:00:10 up 26 days, 4:14, 1 user, load average: 0.02, 0.01, 0.00
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

* Thomas Huth (thuth@redhat.com) wrote:
> On 31/05/2024 16.02, Dr. David Alan Gilbert wrote:
> > * Thomas Huth (thuth@redhat.com) wrote:
> > > On 30/05/2024 09.45, Philippe Mathieu-Daudé wrote:
> > > > We are trying to unify all qemu-system-FOO to a single binary.
> > > > In order to do that we need to remove QAPI target specific code.
> > > > 
> > > > @dump-skeys is only available on qemu-system-s390x. This series
> > > > rename it as @dump-s390-skey, making it available on other
> > > > binaries. We take care of backward compatibility via deprecation.
> > > > 
> > > > Philippe Mathieu-Daudé (4):
> > > >     hw/s390x: Introduce the @dump-s390-skeys QMP command
> > > >     hw/s390x: Introduce the 'dump_s390_skeys' HMP command
> > > >     hw/s390x: Deprecate the HMP 'dump_skeys' command
> > > >     hw/s390x: Deprecate the QMP @dump-skeys command
> > > 
> > > Why do we have to rename the command? Just for the sake of it? I think
> > > renaming HMP commands is maybe ok, but breaking the API in QMP is something
> > > you should consider twice.
> > > 
> > > And even if we decide to rename ... maybe we should discuss whether it makes
> > > sense to come up with a generic command instead: As far as I know, ARM also
> > > has something similar, called MTE. Maybe we also want to dump MTE keys one
> > > day? So the new command should maybe be called "dump-memory-keys" instead?
> > 
> > I think there are at least two different concepts; but I agree it would be
> > nice to keep a single command for matching concepts across different architectures;
> > I can't say I know the details of any, but:
> > 
> >    a) Page table things - I think x86 PKRU/PKEY (???) is a page table thing
> >      where pages marked a special way are associated with keys.
> >      That sounds similar to what the skeys are???
> 
> Sounds a little bit similar, but s390 storage keys are independent from page
> tables. It's rather that each page (4096 bytes) of RAM has an additional
> 7-bit value that contains the storage key and some additional bits. It's
> also usable when page tables are still disabled.
> 
> > I'm not sure the two fit in the same command.
> 
> Does it make sense to dump all the MTE or x86 keys all at once? If so, we
> could maybe come up with an unified command. Otherwise it might not make
> sense, indeed.

So they're all really different granularities:
    s390 - one key/physical page
    ARM MTE - one tag/16 bytes physical
    x86 - per virtual page; then a current register with 16 permission
         sets

For x86 I guess it would be easy to dump the register, and then the
values for a range of virtual addresses.
But then if you dumped a range of physical addresses on ARM MTE you'd
get hundreds times more output than for the equivalent s390.

Dave

>  Thomas
> 
-- 
 -----Open up your eyes, open up your mind, open up your code -------   
/ Dr. David Alan Gilbert    |       Running GNU/Linux       | Happy  \ 
\        dave @ treblig.org |                               | In Hex /
 \ _________________________|_____ http://www.treblig.org   |_______/

