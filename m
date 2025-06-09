Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0C24C5B552
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Jun 2025 15:32:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uOeU5-0005Vn-5C; Mon, 09 Jun 2025 11:32:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jhkim@linux.ibm.com>)
 id 1uOeU3-0005Vc-5j
 for qemu-devel@nongnu.org; Mon, 09 Jun 2025 11:32:23 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jhkim@linux.ibm.com>)
 id 1uOeU0-0006UT-Cc
 for qemu-devel@nongnu.org; Mon, 09 Jun 2025 11:32:22 -0400
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 559D8bT5015039;
 Mon, 9 Jun 2025 15:32:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=VB/DCi
 obJWyUhyq0EE93TEWuPSYXNmdhqVHxNtxB6c8=; b=nUpnTqFUCNl5+w05y95ENg
 dK2C6pSqoSm9A6g4sGxq9jzucYdnCSCOIe0FwlF8uq7qWi9Y/QO/7MpYMrxQI2xt
 8p5hsRZsNBK/JkLdQEaRstzkq2xngp0vF30Jl/UxImPFTD9kzDQ0Qr5tkZA4ALom
 Ku1toSYTxCOBDZrVK5lEGmW6GRzEfZPuLCuP+yfCfOCicM0cHfRTd1ACWjW5E72+
 PXLqwAamU1vhHEiGYnCoOwudpjsK5rzBq6hyG+DgH3tU7p/Br9q3phf/2wl9uAyG
 +n7jXS1jjOh/nUBgZi4IFKaNP5joLF029IUDwgtAXQ5KhOcvGyYHM85RvLn9Feaw
 ==
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 474hhdrp1e-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 09 Jun 2025 15:32:17 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 559DMY9I015180;
 Mon, 9 Jun 2025 15:32:16 GMT
Received: from smtprelay06.dal12v.mail.ibm.com ([172.16.1.8])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 474yrt6hg7-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 09 Jun 2025 15:32:16 +0000
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com
 [10.241.53.104])
 by smtprelay06.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 559FWGaM21824060
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 9 Jun 2025 15:32:16 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 508CF58069;
 Mon,  9 Jun 2025 15:32:16 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id BD5EB5805D;
 Mon,  9 Jun 2025 15:32:15 +0000 (GMT)
Received: from [9.61.254.209] (unknown [9.61.254.209])
 by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Mon,  9 Jun 2025 15:32:15 +0000 (GMT)
Message-ID: <8d8b48eb-32d1-4263-bb19-14179b82ee9a@linux.ibm.com>
Date: Mon, 9 Jun 2025 10:32:13 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] migration: Wait for cpr.sock file to appear before
 connecting
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: Steven Sistare <steven.sistare@oracle.com>, qemu-devel@nongnu.org,
 jjherne@linux.ibm.com, peterx@redhat.com, farosas@suse.de
References: <aEMR6Xjs8tRJ8_sp@redhat.com>
 <b2d90921-0991-4a57-a141-ad0c830f8618@oracle.com>
 <5f211f67-17f7-4b1d-a60a-4ff62645fbfa@linux.ibm.com>
 <ad638089-af36-4f3e-8f3d-61549e9bed06@oracle.com>
 <aEaWC_Lc6c1g821f@redhat.com>
 <f46393bb-115a-489f-aa8d-08348e89d25e@oracle.com>
 <aEbfuM681MJh2S-b@redhat.com>
 <881cb07a-95c7-4f3b-8012-352873e88d64@oracle.com>
 <aEbmvQXyCLMKSy_8@redhat.com>
 <45458e9f-ef59-43e3-abd6-5d923575afa4@linux.ibm.com>
 <aEb2aaOpn4aahXcM@redhat.com>
Content-Language: en-US
From: JAEHOON KIM <jhkim@linux.ibm.com>
In-Reply-To: <aEb2aaOpn4aahXcM@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=DLGP4zNb c=1 sm=1 tr=0 ts=6846fe81 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10 a=dqTSvHTbF_JwFlo1G-AA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: bJUP_hMS8yxoPweCFNxSAu04Z5oG22jg
X-Proofpoint-ORIG-GUID: bJUP_hMS8yxoPweCFNxSAu04Z5oG22jg
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjA5MDExMyBTYWx0ZWRfX93YPJgPdEIjQ
 pVZEUxIbl0f+nv4iz8sDXSFbCOcr2UlmqOvDppzgJhsXiuWqOFsUmtZgyqJuwMbxpKbhff17R/+
 Vs2JkL6CIGFOd5+uLhg8CDeuBTL7q5Zd4lnjl4e1kUnXzHixdloMZYpoU8kspDZjJ0madBvmuuo
 NgK+A481BHddlWc/73XP13KU59AQnbIHhnjTx+z0aVl8pSGEP7fewumFhlScfUJVOR1b4f0uf6w
 n/QEBWMT33eRcgHq3NKOVT5VJXoKeU34xGx7rJ71gnQ46SObq4QChgqXVY4NbiYK0ecyiXLBhUr
 1Ci+1t7+SBwErFF8x/SrUfuDW3uPrzkEvDp2YIpXRoCgPAvfHPrih76gcm5SLmeq4D+1Yq8Rqex
 iDQTvtKxklTnIr1jbI0/Wc74vB4Mg7RYv+a1kruiF8JEDmHFxybfHTG+ZhvVpNrm8R7zCrrV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-09_05,2025-06-09_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 mlxlogscore=999 lowpriorityscore=0 clxscore=1015
 adultscore=0 mlxscore=0 spamscore=0 bulkscore=0 impostorscore=0
 suspectscore=0 phishscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2506090113
Received-SPF: pass client-ip=148.163.156.1; envelope-from=jhkim@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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


On 6/9/2025 9:57 AM, Daniel P. Berrangé wrote:
> On Mon, Jun 09, 2025 at 09:54:02AM -0500, JAEHOON KIM wrote:
>> On 6/9/2025 8:50 AM, Daniel P. Berrangé wrote:
>>> On Mon, Jun 09, 2025 at 09:39:48AM -0400, Steven Sistare wrote:
>>>> On 6/9/2025 9:20 AM, Daniel P. Berrangé wrote:
>>>>> On Mon, Jun 09, 2025 at 09:12:27AM -0400, Steven Sistare wrote:
>>>>>> On 6/9/2025 4:06 AM, Daniel P. Berrangé wrote:
>>>>>>> On Fri, Jun 06, 2025 at 03:37:56PM -0400, Steven Sistare wrote:
>>>>>>>> The easiest solution, with no interface changes, is adding wait_for_socket() in qtest,
>>>>>>>> with this addition from Daniel:
>>>>>>>>
>>>>>>>>       "With the busy wait you risk looping forever if the child (target) QEMU
>>>>>>>>       already exited for some reason without ever creating the socket. You
>>>>>>>>       can mitigate this by using 'kill($PID, 0)' in the loop and looking
>>>>>>>>       for -ERSCH, but this only works if you know the pid involved."
>>>>>>>>
>>>>>>>> Daniel also suggested:
>>>>>>>>       "For the tests, passing a pre-opened UNIX socket FD could work"
>>>>>>>>
>>>>>>>> Note we can not use any of the standard chardev options to specify such a socket,
>>>>>>>> because the cpr socket is created before chardevs are created.
>>>>>>>>
>>>>>>>> Perhaps we could specify the fd in an extension of the MigrationChannel MigrationAddress.
>>>>>>>> { 'union': 'MigrationAddress',
>>>>>>>>       'base': { 'transport' : 'MigrationAddressType'},
>>>>>>>>       'discriminator': 'transport',
>>>>>>>>       'data': {
>>>>>>>>         'socket': 'SocketAddress',
>>>>>>>>         'exec': 'MigrationExecCommand',
>>>>>>>>         'rdma': 'InetSocketAddress',
>>>>>>>>         'file': 'FileMigrationArgs',
>>>>>>>>         'fd':   'FdMigrationArgs' } }           <-- add this
>>>>>>>>
>>>>>>>> That would be useful for all clients, but this is asking a lot from you,
>>>>>>>> when you are just trying to fix the tests.
>>>>>>> Note, 'SocketAddress' already has an option for declaring a FD that
>>>>>>> represents a socket.
>>>>>> Yes, but if I understand, you proposed passing an fd that represents a
>>>>>> pre-listened socket, which requires target qemu to accept() first.  The
>>>>>> existing FdSocketAddress is ready to read.  We could add a boolean to enable
>>>>>> the new behavior.
>>>>> It can do both actually - it depends on what APIs the QEMU uses the
>>>>> SocketAddress with.
>>>>>
>>>>> If it is used with qio_channel_socket_connect* the FD must be an
>>>>> active peer connection.
>>>>>
>>>>> If it is used with qio_channel_socket_listen*/qio_net_listener* the
>>>>> FD must be listener socket.
>>>> Fair enough.  cpr currently listens here, and we could add a case for the FD:
>>>>
>>>>     QEMUFile *cpr_transfer_input(MigrationChannel *channel, Error **errp)
>>>>     {
>>>>       MigrationAddress *addr = channel->addr;
>>>>
>>>>       if (addr->transport == MIGRATION_ADDRESS_TYPE_SOCKET &&
>>>>           addr->u.socket.type == SOCKET_ADDRESS_TYPE_UNIX) {
>>>>           ...
>>>>           g_autoptr(QIONetListener) listener = qio_net_listener_new();
>>>>
>>>> Or to use my socketpair() suggestion, that function would also need changes,
>>>> calling qio_channel_socket_connect.
>>>>
>>>> Which do you think is better for clients -- socketpair or pre-listened?
>>> Please just use the existing SocketAddress functionality, as that's used
>>> throughout QEMU - a special case with socketpair for migration is not
>>> desirable.
>>>
>>> The SocketAddress stuff is what libvirt's used for many years now to
>>> address the race condition with QMP listeners.
>> Dear Daniel and Steve,
>>
>> Thank you both for your valuable insights.
>>
>> To clarify regarding the socket handling approach:
>> If I do not use socketpair() and instead pass a pre-listened FD to the target, which then calls accept(),
>> it seems this could mitigate some race condition. However, isn't there still a risk that the old QEMU might try to
>> connect before the target QEMU calls accept(), thereby resulting in the same race condition?
> No, that's fine. The kernel will queue all incoming connections
> until accept() is called. So essentially the source QEMU connect()
> will get blocked until dst QEMU accept()s, which is exactly the
> semantics we want.
>
> With regards,
> Daniel
Thank you for the clarification.

If, as you said, the kernel queues incoming connections until accept() 
is called, then the race condition should not occur.
I'll take this approach into consideration.

- Jaehoon Kim.


