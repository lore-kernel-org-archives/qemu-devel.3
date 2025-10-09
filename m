Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63472CCD185
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Oct 2025 13:18:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v6qWY-0006xw-3R; Thu, 09 Oct 2025 09:17:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dg@treblig.org>) id 1v6qWW-0006uO-4o
 for qemu-devel@nongnu.org; Thu, 09 Oct 2025 09:17:36 -0400
Received: from mx.treblig.org ([2a00:1098:5b::1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dg@treblig.org>) id 1v6qWM-0001V3-Bx
 for qemu-devel@nongnu.org; Thu, 09 Oct 2025 09:17:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
 ; s=bytemarkmx;
 h=Content-Type:MIME-Version:Message-ID:Subject:From:Date:From
 :Subject; bh=WAtTElTWF+SlJcrmzJlRcuW+Th2ePUBPi25qPrldTcM=; b=rhdLxGnbxuf+KamL
 +DnDZ217H44x2SA6sanOs7cOvHd7rJ8ibb1TcKEGaF8AUVVQufsF6CIuC7OJjpzwJJfBhhISF77EZ
 edEYUz3xZXanOO8HnV0Jel/yzWLAWWtQEgpAGV2vPYTMlq/LxFrm+jx1NCDpZaNWMxoEIjoJXbHbi
 BoeSzOIPGsMTOJNClqaD0ar6HXJN+x7cwg+OJI+sXcXPCi6gdsx7ebjtEU0Ul0K9OuSI9aCVdoJUM
 NUgGG/QWghYlvuFMhhPJE+HKmzR0mH1ghRDbDPPTLdAcZNAa/Yuy0mTQsyejKkLFvFrDjtSSy92LF
 6Tg7R69vt02L60FH0A==;
Received: from dg by mx.treblig.org with local (Exim 4.96)
 (envelope-from <dg@treblig.org>) id 1v6qWC-00FV2n-3C;
 Thu, 09 Oct 2025 13:17:16 +0000
Date: Thu, 9 Oct 2025 13:17:16 +0000
From: "Dr. David Alan Gilbert" <dave@treblig.org>
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org, Laurent Vivier <lvivier@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Markus Armbruster <armbru@redhat.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Eric Blake <eblake@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>, Zhao Liu <zhao1.liu@intel.com>
Subject: Re: [PATCH v2] hw/uefi: add "info ovmf-log" + "query-ovmf-log"
 monitor commands
Message-ID: <aOe13CGfaww9diMq@gallifrey>
References: <20251007135216.1687648-1-kraxel@redhat.com>
 <aOcWOQJt-zLbiyUK@gallifrey> <aOdggKKyDtf3z57J@redhat.com>
 <aOefUN5_bSKjWPLc@gallifrey> <aOejzqM74_NiOHJJ@redhat.com>
 <ef6m5kcsotrgshbtrj2jawjk7waq5ggrt42ugazkxs7u3jt2sq@ccef4acxnshv>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <ef6m5kcsotrgshbtrj2jawjk7waq5ggrt42ugazkxs7u3jt2sq@ccef4acxnshv>
X-Chocolate: 70 percent or better cocoa solids preferably
X-Operating-System: Linux/6.1.0-34-amd64 (x86_64)
X-Uptime: 13:16:07 up 164 days, 21:29,  1 user,  load average: 0.05, 0.05, 0.01
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

* Gerd Hoffmann (kraxel@redhat.com) wrote:
>   Hi,
> 
> > > OK, what about sanitisation - if that text contains random binary what happens,
> > > or should we make sure it's sanitised?
> > 
> > As prior art, the QGA  'guest-exec' command will return stdout/stderr
> > of the command in base64 format.  The downside is that it is bloated
> > in size, but it is at least safe wrt JSON encoding.
> 
> In theory the log should just be text, but I've managed to f*ck up
> logging with broken patches in the past, with the result that random
> binary crap landed in the log.
> 
> So sending base64 in the json reply makes sense to me.  Do we have a
> qapi type for that?  Or should I use string?
> 
> > The HMP command could still dump the raw data IMHO, as that's human
> > facing and base64 is horrible for human consumption.
> 
> And probably a hmp implementation /not/ using the qmp command so we
> don't convert text -> base64 -> text ...

Haha yes; if you can run the HMP through an 'isprint()' or similar
that would be good; I guess you want to keep cr/lf's and maybe tabs,
but you probably don't want anything that screw up the terminal?

Dave

> take care,
>   Gerd
> 
-- 
 -----Open up your eyes, open up your mind, open up your code -------   
/ Dr. David Alan Gilbert    |       Running GNU/Linux       | Happy  \ 
\        dave @ treblig.org |                               | In Hex /
 \ _________________________|_____ http://www.treblig.org   |_______/

