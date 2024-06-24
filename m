Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F102EC3064D
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Jun 2024 12:52:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sLjAH-0000nN-04; Mon, 24 Jun 2024 08:51:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mchehab+huawei@kernel.org>)
 id 1sLgGq-0005UZ-Ba
 for qemu-devel@nongnu.org; Mon, 24 Jun 2024 05:45:56 -0400
Received: from dfw.source.kernel.org ([139.178.84.217])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mchehab+huawei@kernel.org>)
 id 1sLgGo-0001gb-Cu
 for qemu-devel@nongnu.org; Mon, 24 Jun 2024 05:45:56 -0400
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id 078CF60B8D;
 Mon, 24 Jun 2024 09:45:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0246FC2BBFC;
 Mon, 24 Jun 2024 09:45:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1719222345;
 bh=cW52zxJgpVsSrE9cLev7A24Pl9+DDNAp4ic425Ti+Y4=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=EVvXwvTa2dRso95ijmvxkEJ8uAhkbmG37zOi+grH8prpdua6kADnowYph3H4mI6+g
 JkKtGCwrutt4IJnNqvNDIYX0YHJHV35/afDZZh8vCfWmvWXGQDZMl+CzNDS5a3iPre
 AXbfEpO30WPRVmcVvicq0wk4IefC+thYSegFbpRXdRH9q79whpXhO5DXxwUXpCHB22
 ZqpJV3IWeID8vFwEnEH3kNvSsKFsXw8Aq8dXhi5ir0EnZKXit3Am/8upEBGDnWLWzL
 2R6Bo6feNlIHLKqIXVIkiiJfqJRKA23Dvp6KLxxdLlnBicDmP7JGDfUt/qQ7HvN68I
 sa8162M5uux4w==
Date: Mon, 24 Jun 2024 11:45:40 +0200
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
Cc: <shiju.jose@huawei.com>, <qemu-devel@nongnu.org>,
 <linux-edac@vger.kernel.org>, <tanxiaofei@huawei.com>,
 <prime.zeng@hisilicon.com>, <linuxarm@huawei.com>
Subject: Re: [RFC PATCH 1/1] hw/arm: FW first ARM processor error injection.
Message-ID: <20240624114540.400b70a1@coco.lan>
In-Reply-To: <20240621193316.00000d83@Huawei.com>
References: <20240621165115.336-1-shiju.jose@huawei.com>
 <20240621193316.00000d83@Huawei.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.42; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=139.178.84.217;
 envelope-from=mchehab+huawei@kernel.org; helo=dfw.source.kernel.org
X-Spam_score_int: -71
X-Spam_score: -7.2
X-Spam_bar: -------
X-Spam_report: (-7.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.149,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_HI=-5, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Mon, 24 Jun 2024 08:51:19 -0400
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

Em Fri, 21 Jun 2024 19:33:16 +0100
Jonathan Cameron <Jonathan.Cameron@Huawei.com> escreveu:

> On Fri, 21 Jun 2024 17:51:15 +0100
> <shiju.jose@huawei.com> wrote:
> 
> > From: Shiju Jose <shiju.jose@huawei.com>  
> Thanks for posting this.
> 
> Given this is going to linux-edac, probably should mention
> this is QEMU based error injection.  For cross postings
> between kernel related and qemu lists I tend to stick
> qemu in the [] of the patch description.

Thank you for that! It is really useful. Btw, I'm using a small
script to do the error injection using netcat (nc), and assuming
that the QMP interface used for error injection will be started 
at localhost port 4445, e. g. qemu is started with:

	-qmp tcp:localhost:4445,server=on,wait=off

Btw, I added some instructions about how to use it under rasdaemon
page:

	https://github.com/mchehab/rasdaemon/wiki/Error-injection-testing

Feel free to improve it.

Thanks,
Mauro

---


#!/bin/bash

trap 'catch $LINENO "$BASH_COMMAND"' ERR
catch() {
	echo "Error on line $1: $2"
	exit 1
}

ERROR_DEFAULT='"cache-error"'
ERROR=""

HELP="$0 [<-c|--cache-error> <-t|--tlb-error> <-b|--bus-error> <-v|--vendor-error>|--micro-arch-error]"

while [ "$1" != "" ]; do
	case "$1" in
		-c|--cache-error)
			if [ ! -z "$ERROR" ]; then ERROR="$ERROR, "; fi
			ERROR+='"cache-error"'
			;;
		-t|--tlb-error)
			if [ ! -z "$ERROR" ]; then ERROR="$ERROR, "; fi
			ERROR+='"tlb-error"'
			;;
		-b|--bus-error)
			if [ ! -z "$ERROR" ]; then ERROR="$ERROR, "; fi
			ERROR+='"bus-error"'
			;;
		-v|--vendor-error|--micro-arch-error)
			if [ ! -z "$ERROR" ]; then ERROR="$ERROR, "; fi
			ERROR+='"micro-arch-error"'
			;;
		help|-h|--help)
			echo $HELP
			exit 0
			;;
	esac
	shift
done


if [ -z "$ERROR" ]; then
	ERROR=$ERROR_DEFAULT
fi

CACHE_MSG='{ "execute": "qmp_capabilities" } '
CACHE_MSG+='{ "execute": "arm-inject-error", "arguments": { "errortypes": ['$ERROR'] } }'

echo $CACHE_MSG
echo $CACHE_MSG | nc -v localhost 4445



