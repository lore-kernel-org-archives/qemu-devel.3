Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F773C282DE
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Mar 2025 12:32:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1trcIf-0005jj-Ge; Mon, 10 Mar 2025 08:32:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dg@treblig.org>)
 id 1trcHx-0005ak-Go; Mon, 10 Mar 2025 08:31:21 -0400
Received: from mx.treblig.org ([2a00:1098:5b::1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dg@treblig.org>)
 id 1trcHt-0006ZN-UK; Mon, 10 Mar 2025 08:31:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
 ; s=bytemarkmx;
 h=Content-Type:MIME-Version:Message-ID:Subject:From:Date:From
 :Subject; bh=PC2rKpsiEjh3Imi2o4iS3KshXmSKtchm8Wk7PK3Ltuw=; b=LOJ/6Fv/1H6s3jZt
 8umbukbLuu/8MAvfCgZiG7uSis8niRCH8I2YwQdAvMN991ULazJtmidj56Kds8DcVUImzFahzmWyW
 /3H378AgIXHFRIdDeWEuTYuLFdO8GsHKa7GOoWoUA+7c42cS+rgkZGiw+qwmRT/nBRS7sPyj0rYu/
 /GBST2pyzA0PPdsvcaT1w8X19QDApCdxrEcRd2lKb5hjItGb5s4LU9iK+ofeuel4Yqlkzm2Eyo0Rm
 GtlKAt/Sz4y0tuHI9aUhLgEpWHdwXd1k7yhAnH9jF1LtcVyxMm7Le9kv4/ea1wmkMYjlmXYu46QsX
 WlfWR2GaJbmCO2Ic9A==;
Received: from dg by mx.treblig.org with local (Exim 4.96)
 (envelope-from <dg@treblig.org>) id 1trcHZ-003s4L-0F;
 Mon, 10 Mar 2025 12:30:57 +0000
Date: Mon, 10 Mar 2025 12:30:57 +0000
From: "Dr. David Alan Gilbert" <dave@treblig.org>
To: Thomas Huth <thuth@redhat.com>
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
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
Message-ID: <Z87bgdM4uJLR6RWS@gallifrey>
References: <20240530074544.25444-1-philmd@linaro.org>
 <cb4028fc-9596-47f3-9468-f8912dd48aed@redhat.com>
 <Zl20rAjHLJlZkwxE@redhat.com>
 <fda186da-2e31-42d6-8dd6-0ea3141a73e6@linaro.org>
 <d74d3ff3-3830-4682-87e3-a42ed57068d9@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d74d3ff3-3830-4682-87e3-a42ed57068d9@redhat.com>
X-Chocolate: 70 percent or better cocoa solids preferably
X-Operating-System: Linux/6.1.0-21-amd64 (x86_64)
X-Uptime: 12:20:24 up 305 days, 23:34,  1 user,  load average: 0.03, 0.01, 0.00
User-Agent: Mutt/2.2.12 (2023-09-09)
Received-SPF: pass client-ip=2a00:1098:5b::1; envelope-from=dg@treblig.org;
 helo=mx.treblig.org
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
> On 09/03/2025 19.55, Pierrick Bouvier wrote:
> > On 6/3/24 05:18, Daniel P. Berrangé wrote:
> > > On Fri, May 31, 2024 at 06:47:45AM +0200, Thomas Huth wrote:
> > > > On 30/05/2024 09.45, Philippe Mathieu-Daudé wrote:
> > > > > We are trying to unify all qemu-system-FOO to a single binary.
> > > > > In order to do that we need to remove QAPI target specific code.
> > > > > 
> > > > > @dump-skeys is only available on qemu-system-s390x. This series
> > > > > rename it as @dump-s390-skey, making it available on other
> > > > > binaries. We take care of backward compatibility via deprecation.
> > > > > 
> > > > > Philippe Mathieu-Daudé (4):
> > > > >     hw/s390x: Introduce the @dump-s390-skeys QMP command
> > > > >     hw/s390x: Introduce the 'dump_s390_skeys' HMP command
> > > > >     hw/s390x: Deprecate the HMP 'dump_skeys' command
> > > > >     hw/s390x: Deprecate the QMP @dump-skeys command
> > > > 
> > > > Why do we have to rename the command? Just for the sake of it? I think
> > > > renaming HMP commands is maybe ok, but breaking the API in QMP is something
> > > > you should consider twice.
> > > 
> > > That was going to be my question too. Seems like its possible to simply
> > > stub out the existing command for other targets.
> > > 
> > > The renaming is just window dressing.
> > > 
> > 
> > Working on single-binary topic means specificities from every qemu
> > binary/ architecture has to be merged together. Despite appearing has a
> > bad thing now, it's definitely a step forward for QEMU, and will allow
> > to enable new usages.
> > 
> > The hard way is to trigger a deep refactoring, involving lengthy
> > conversations where compromises have to be found ("let's implement this
> > for all arch"). The pragmatic way is to eliminate obvious stuff.
> > 
> > This command is specific to an arch, so renaming is a good and obvious
> > strategy. For the backward compatible anxious developer, another
> > strategy would be to simply declare this command if the running target
> > is s390x. But then, you create a precedent to do something that should
> > not have existed in the first place.
> > 
> > +1 for the renaming, and hope that users of this command are able to
> > change a line in their script to adapt to the new command.
> 
> Sorry, but no: We've got plenty of other target specific commands...
> rtc-reset-reinjection , query-sev, query-gic-capabilities, just to name some
> few. So unless you provide a patch series to rename *all* of them and
> deprecate the previous names, I don't see the point why changing just one
> single s390x command is necessary.

I'd probably agree; mind you, it wouldn't be a bad convention to
adopt in general.
For HMP, since there's no need to have a fixed schema for a command,
it would be fine to have a generic command for all architectures
that have a similar idea even if their data is very different.

Dave

>  Thomas
> 
-- 
 -----Open up your eyes, open up your mind, open up your code -------   
/ Dr. David Alan Gilbert    |       Running GNU/Linux       | Happy  \ 
\        dave @ treblig.org |                               | In Hex /
 \ _________________________|_____ http://www.treblig.org   |_______/

