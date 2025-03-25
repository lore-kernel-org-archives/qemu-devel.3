Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0DCA5C35FFC
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Mar 2025 15:08:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tx5t4-0002e4-Rh; Tue, 25 Mar 2025 11:08:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <milesg@linux.ibm.com>)
 id 1tx5sz-0002Zd-1U
 for qemu-devel@nongnu.org; Tue, 25 Mar 2025 11:08:13 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <milesg@linux.ibm.com>)
 id 1tx5sw-0007Mr-Qm
 for qemu-devel@nongnu.org; Tue, 25 Mar 2025 11:08:12 -0400
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52P96odZ024126;
 Tue, 25 Mar 2025 15:08:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:reply-to:subject:to; s=pp1;
 bh=kOZq94dXE53byI+O9kvNV7s71VG9BQ6+IaULwtov1cg=; b=FwOFYzBi/Jsj
 6Txn/8DH3LxCipwslY5VdijhEIyVp06q0WCck6LV2udxy2U41C3+C5xsNsyXN3Xj
 MOUgJmWfqCl5lC8cVwOtXjZzJ2yM27daUYC/scj66aEqU4rRV6dcUzWiJLQsJ/J1
 UC0YiYWgfkznZ9a2kzCB3Gwj1ze98/oYfNHb77r/5WIWuvgJ62SRXQXuTTRK7G7j
 PVGXWoMGaQM1vaTWllKQ19mXZAK1YNAyAlt+N1Ge4LtwZMC7ex49EmTF18W1+t+H
 +N34/eKgpJTfkQLq/qQmU5SWIImMBwM6ZLlOf14UE1dCW2HFm0/wxI9BjaRREMBF
 t8f/EAwdBw==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 45kekyvdek-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 25 Mar 2025 15:08:07 +0000 (GMT)
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
 by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 52PEr1x1028902;
 Tue, 25 Mar 2025 15:08:06 GMT
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 45kekyvdeg-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 25 Mar 2025 15:08:06 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 52PC9bou030418;
 Tue, 25 Mar 2025 15:08:06 GMT
Received: from smtprelay03.wdc07v.mail.ibm.com ([172.16.1.70])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 45j7htc511-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 25 Mar 2025 15:08:06 +0000
Received: from smtpav06.wdc07v.mail.ibm.com (smtpav06.wdc07v.mail.ibm.com
 [10.39.53.233])
 by smtprelay03.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 52PF83OO15401500
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 25 Mar 2025 15:08:03 GMT
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 4714C58064;
 Tue, 25 Mar 2025 15:08:05 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id DAE2A5803F;
 Tue, 25 Mar 2025 15:08:04 +0000 (GMT)
Received: from mambor8.rchland.ibm.com (unknown [9.10.239.198])
 by smtpav06.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 25 Mar 2025 15:08:04 +0000 (GMT)
Message-ID: <f0fdbf4b2de592383979eb2e58855b2d6fc7c33a.camel@linux.ibm.com>
Subject: Re: Best practice for issuing blocking calls in response to an event
From: Miles Glenn <milesg@linux.ibm.com>
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: qemu-devel@nongnu.org, Philippe =?ISO-8859-1?Q?Mathieu-Daud=E9?=
 <philmd@linaro.org>
Date: Tue, 25 Mar 2025 10:08:04 -0500
In-Reply-To: <CAJSP0QX-T=8Fw=x_De2HdiNVKNQf2nTbrHp5cnUeJfFzxVONwQ@mail.gmail.com>
References: <9d87fed729b2697605bcf5b6062669b6239e5c0f.camel@linux.ibm.com>
 <CAJSP0QXqseVpaHZEfhJv7nZ8N18PGQqpW-tb9LCkGyvOKvW_zQ@mail.gmail.com>
 <38af196895ab98bafb5423cbc390a1cb79e764df.camel@linux.ibm.com>
 <CAJSP0QX-T=8Fw=x_De2HdiNVKNQf2nTbrHp5cnUeJfFzxVONwQ@mail.gmail.com>
Organization: IBM
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-27.el8_10) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: c22pOoCFwVY9rqYcFq7cglWBbkJPwfL_
X-Proofpoint-GUID: 4jC6eaYHg-W_G42NI89cTZvQHYaWpiPH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-25_06,2025-03-25_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0
 adultscore=0 impostorscore=0 malwarescore=0 spamscore=0 bulkscore=0
 mlxlogscore=999 mlxscore=0 lowpriorityscore=0 priorityscore=1501
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502280000 definitions=main-2503250105
Received-SPF: pass client-ip=148.163.158.5; envelope-from=milesg@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H2=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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
Reply-To: milesg@linux.ibm.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Mon, 2025-03-24 at 14:35 -0400, Stefan Hajnoczi wrote:
> On Fri, Mar 21, 2025 at 11:17 AM Miles Glenn <milesg@linux.ibm.com> wrote:
> > On Thu, 2025-03-20 at 16:09 -0400, Stefan Hajnoczi wrote:
> > > On Thu, Mar 20, 2025 at 12:34 PM Miles Glenn <milesg@linux.ibm.com> wrote:
> > > > Hello,
> > > > 
> > > > I am attempting to simulate a system with multiple CPU
> > > > architectures.  To do this I am starting a unique QEMU process for each
> > > > CPU architecture that is needed. I'm also developing some QEMU code
> > > > that aids in transporting MMIO transactions across the process
> > > > boundaries using sockets.
> > > 
> > > I have CCed Phil. He has been working on heterogenous target emulation
> > > and might be interested.
> > > 
> > > > The design takes MMIO request messages off of a socket, services the
> > > > request by calling address_space_ldq_be(), then sends a response
> > > > message (containing the requested data) over the same
> > > > socket.  Currently, this is all done inside the socket IOReadHandler
> > > > callback function.
> > > 
> > > At a high level this is similar to the vfio-user feature where a PCI
> > > device is emulated in a separate process. This also involves sending
> > > messages describing QEMU's MemoryRegion accesses. See the "remote"
> > > machine type in QEMU to look at the code.
> > > 
> > > > This works as long as the targeted register exists in the same QEMU
> > > > process that received the request.  However, If the register exists in
> > > > another QEMU process, then the call to address_space_ldq_be() results
> > > > in another socket message being sent to that QEMU process, requesting
> > > > the data, and then waiting (blocking) for the response message
> > > > containing the data.  In other words, it ends up blocking inside the
> > > > event handler and even though the QEMU process containing the target
> > > > register was able to receive the request and send the response, the
> > > > originator of the request is unable to receive the response until it
> > > > eventually times out and stops blocking.  Once it times out and stops
> > > > blocking, it does receive the response, but now it is too late.
> > > > 
> > > > Here's a summary of the stack up to where the code blocks:
> > > > 
> > > > IOReadHandler callback
> > > >   calls address_space_ldq_be()
> > > >     resolves to mmio read op of a remote device
> > > >       sends request over socket and waits (blocks) for response
> > > > 
> > > > So, I'm looking for a way to handle the work of calling
> > > > address_space_ldq_be(), which might block when attempting to read a
> > > > register of a remote device, without blocking inside the IOReadHandler
> > > > callback context.
> > > > 
> > > > I've done a lot of searches and reading about how to do this on the web
> > > > and in the QEMU code but it's still not really clear to me how this
> > > > should be done in QEMU.  I've seen a lot about using coroutines to
> > > > handle cases like this. Is that what I should be using here?
> > > 
> > > The fundamental problem is that address_space_ldq_be() is synchronous,
> > > so there is no way to return back to the caller until the response has
> > > been received.
> > > 
> > > vfio-user didn't solve this problem. It simply blocks until the
> > > response is received, but it does drop the Big QEMU Lock during this
> > > time so that other vCPU threads can run. For example, see
> > > hw/remote/proxy.c:send_bar_access_msg() and
> > > mpqemu_msg_send_and_await_reply().
> > > 
> > > QEMU supports nested event loops, but they come with their own set of
> > > gotchas. The way a nested event loop might help here is to send the
> > > request and then call aio_poll() to receive the response in another
> > > IOReadHandler. This way other event loop processing can take place
> > > while waiting in address_space_ldq_be().
> > > 
> > > The second problem is that this approach where QEMU processes send
> > > requests to each other needs to be implemented carefully to avoid
> > > deadlocks. For example, devices that do DMA could load/store memory
> > > belonging to another device handled by another QEMU. Once there is an
> > > A -> B -> A situation it could deadlock.
> > > 
> > > Both vfio-user and vhost-user have similar issues with their
> > > bi-directional communication where a device emulation process can send
> > > a message to QEMU while processing a message from QEMU. Deadlock can
> > > be avoided if the code is structured so that QEMU is able to receive
> > > new requests during the time when it is waiting for a response.
> > > 
> > > Stefan
> > 
> > Stefan, Thank you for the quick response and great information!
> > 
> > I'm not sure if this is the best way, but I was able to get things
> > working today using the coroutine approach.
> > 
> > Now, the aforementioned stack looks like this:
> > 
> > IOReadHandler callback receives request
> >   enters coroutine
> >     calls address_space_ldq_be()
> >       resolves to mmio read op of a remote device
> >         sends request
> > over socket
> >         detects coroutine context and
> >         calls qemu_coroutine_yield() instead of blocking
> >   returns to callback
> > 
> > <time passes>
> > 
> > IOReadHandler callback receives response
> >   re-enters coroutine
> >         mmio read op returns data received in response message
> >     address_space_ldq_be() returns
> >   coroutine completes and returns to callback
> > 
> > While this works, I couldn't help but notice that the coroutine concept
> > seems to be like a form of multithreading.  Is there some advantage to
> > using coroutines over doing the work in another thread?  Does QEMU
> > offer an interface that allows for a callback to queue up work that can
> > be handled by another thread or a pool of threads?
> 
> Coroutines make it easier to write concurrent code in an event loop.
> The alternative is to write asynchronous callback functions, which is
> tedious for sequences with multiple steps that need to wait for I/O.
> 
> Coroutines do not offer parallelism, so they are not replacement for
> multi-threading. QEMU is mostly event-driven rather than
> multi-threaded. Usually only computation in QEMU that really needs its
> own CPU runs in its own thread (vCPUs, compression, blocking syscalls
> when there is no alternative, etc).
> 
> There are advantages to using coroutines: less synchronization is
> necessary than with threads (you can be sure no other coroutine will
> run in the same thread while your code is running) and this eliminates
> most thread-safety issues. Also, event loops are seen as more scalable
> than threads (lots of historical resources, for example
> http://www.kegel.com/c10k.html). One QEMU-specific advantage of
> coroutines: coroutine code has access to all of QEMU's APIs that
> require the event loop whereas threads need to take extra steps to
> interact with the rest of QEMU.
> 
> Stefan

Thanks for the explanation, Stefan!

Glenn


