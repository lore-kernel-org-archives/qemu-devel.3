Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9E19C48292
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Feb 2024 18:59:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rX4BQ-0002TI-03; Mon, 05 Feb 2024 13:59:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>) id 1rX4BO-0002So-At
 for qemu-devel@nongnu.org; Mon, 05 Feb 2024 13:59:06 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>) id 1rX4BM-0006LK-8Q
 for qemu-devel@nongnu.org; Mon, 05 Feb 2024 13:59:06 -0500
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 415IIS8u006960; Mon, 5 Feb 2024 18:59:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 content-transfer-encoding : in-reply-to; s=pp1;
 bh=fJ+M5CmeEXdwuoubkhe0KZ3Y7dZTw0LtLbmXUJ4uraM=;
 b=Givm7L55VZMiUxGO8A+8MqbAprwpeXjNLaYC/TLyrHcuD1w5VDkBkiGAs8gmcyRzh6jj
 mHS57FjwSHbkqXrUzaDiA/xWdxmhZeMxID8eI8RIM+IVU+kCfr4Xz6MRStWNOsBgU4uB
 rVeh9gmc6Ye0ByKnSWUyP4NcErPjSX03tgbYUClT9Pc7p3rRQtTzx8+Ms+zj9OJE0pGD
 gkY7g9gMCgJIMhoUPDTT32llJPmv5BKuDvhpglVHz3vHx0vXZ3pP1Kwji2X6lOVEEzqQ
 QMOTS2hSRc7LwmnFE7q6C/4N3l5pk6uqZYBOYyTpazo0QZvi9yttWA43tWp2pKp0WKg8 7A== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3w34u50smd-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 05 Feb 2024 18:59:00 +0000
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 415Ik8d7005458;
 Mon, 5 Feb 2024 18:59:00 GMT
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3w34u50rw5-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 05 Feb 2024 18:58:59 +0000
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 415ImK6d019996; Mon, 5 Feb 2024 18:55:15 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 3w1ytstjvy-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 05 Feb 2024 18:55:14 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com
 [10.20.54.101])
 by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 415ItDtO46400116
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 5 Feb 2024 18:55:13 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 3BF8520040;
 Mon,  5 Feb 2024 18:55:13 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 8410A20043;
 Mon,  5 Feb 2024 18:55:12 +0000 (GMT)
Received: from heavy (unknown [9.171.57.170])
 by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTPS;
 Mon,  5 Feb 2024 18:55:12 +0000 (GMT)
Date: Mon, 5 Feb 2024 19:55:11 +0100
From: Ilya Leoshkevich <iii@linux.ibm.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Ed Maste <emaste@freebsd.org>, Li-Wen Hsu <lwhsu@freebsd.org>,
 Warner Losh <imp@bsdimp.com>
Cc: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>,
 Thomas Huth <thuth@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Beraldo Leal <bleal@redhat.com>, Kyle Evans <kevans@freebsd.org>,
 qemu-devel@nongnu.org
Subject: Re: Re: [PATCH v2 4/4] meson: Link with libinotify on FreeBSD
Message-ID: <sljvmkdju4qgy6mabuzikyaiujn4w2ctnnxutkdk7kp7czj4hy@muwe2dwe4qyp>
References: <20240205181352.1567-1-iii@linux.ibm.com>
 <20240205181352.1567-5-iii@linux.ibm.com>
 <b6ab054b-47b4-49e5-ada7-6a407d54207b@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b6ab054b-47b4-49e5-ada7-6a407d54207b@linaro.org>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: TvhRkO-iRtsQd8MgShsfGwy7yWgzLNhp
X-Proofpoint-ORIG-GUID: 15tbgT7JxilwQLJx4eDtBcmeusZ6O1rH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-05_13,2024-01-31_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 mlxscore=0
 suspectscore=0 bulkscore=0 phishscore=0 mlxlogscore=999 priorityscore=1501
 spamscore=0 malwarescore=0 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2402050141
Received-SPF: pass client-ip=148.163.158.5; envelope-from=iii@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Mon, Feb 05, 2024 at 07:36:32PM +0100, Philippe Mathieu-Daudé wrote:
> Hi Ilya,
> 
> On 5/2/24 19:11, Ilya Leoshkevich wrote:
> > make vm-build-freebsd fails with:
> > 
> >      ld: error: undefined symbol: inotify_init1
> >      >>> referenced by filemonitor-inotify.c:183 (../src/util/filemonitor-inotify.c:183)
> >      >>>               util_filemonitor-inotify.c.o:(qemu_file_monitor_new) in archive libqemuutil.a
> > 
> > On FreeBSD inotify functions are defined in libinotify.so. Add it to
> > the dependencies.
> > 
> > Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
> > ---
> >   meson.build      | 12 +++++++++++-
> >   util/meson.build |  6 +++++-
> >   2 files changed, 16 insertions(+), 2 deletions(-)
> 
> (for some reason your git-diff context is very verbose,
>  making review somehow annoying).

This is because of patch 3. It's essentially the snippet that Daniel
posted, except that patch -p1 applied it at a wrong location! So I
figured I'll send this series with a larger context, but I couldn't
find how to apply this setting to just 1 patch in git send-email.

> > +# libinotify-kqueue
> > +inotify = not_found
> > +if host_os == 'freebsd'
> > +  inotify = cc.find_library('inotify')
> > +endif
> > +
> >   #################
> >   # config-host.h #
> >   #################
> 
> 
> > @@ -2376,61 +2382,62 @@ have_asan_fiber = false
> >   if get_option('sanitizers') and \
> >      not cc.has_function('__sanitizer_start_switch_fiber',
> >                            args: '-fsanitize=address',
> >                            prefix: '#include <sanitizer/asan_interface.h>')
> >     warning('Missing ASAN due to missing fiber annotation interface')
> >     warning('Without code annotation, the report may be inferior.')
> >   else
> >     have_asan_fiber = true
> >   endif
> >   config_host_data.set('CONFIG_ASAN_IFACE_FIBER', have_asan_fiber)
> >   # has_header_symbol
> 
> 
> >   config_host_data.set('CONFIG_INOTIFY',
> >                        cc.has_header_symbol('sys/inotify.h', 'inotify_init'))
> >   config_host_data.set('CONFIG_INOTIFY1',
> > -                     cc.has_header_symbol('sys/inotify.h', 'inotify_init1'))
> > +                     cc.has_header_symbol('sys/inotify.h', 'inotify_init1') and
> > +                     (host_os != 'freebsd' or inotify.found()))
> 
> Maybe we could use the same pattern as 'have_asan_fiber':
> 
>  have_inotify_init1 = cc.has_header_symbol('sys/inotify.h', 'inotify_init1')
>  if have_inotify_init1 and host_os == 'freebsd'
>    have_inotify_init1 = cc.find_library('inotify')
>  endif
>  config_host_data.set('CONFIG_INOTIFY1', have_inotify_init1)

I agree, this looks nicer. I will send a v3.

> I wonder why we don't need the similar library check for the
> inotify_init symbol.

Sounds reasonable, it's just that currently the respective config value
is used only in linux-user, but for completeness it won't hurt.

> 
> Regards,
> 
> Phil.

