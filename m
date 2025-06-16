Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42F49C71136
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Jun 2025 14:45:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uRB4R-0007ZG-GW; Mon, 16 Jun 2025 10:44:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1uRB4M-0007Yu-NT
 for qemu-devel@nongnu.org; Mon, 16 Jun 2025 10:44:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1uRB4H-0000sb-Et
 for qemu-devel@nongnu.org; Mon, 16 Jun 2025 10:44:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1750085050;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=whkjWvSS+kxqV6pLBQMuMJyqdPMCbpQRti1s2FjOsxI=;
 b=NrgT583JI8oihWrYMelkFC31xffJCA51HyewXMUQwvB+Eth6VPGS+d953ruAD/lqlK2gqp
 cPIMHuo2xEVZvZW7BB9FnRygBeYwiUqxUviPxxCkE6DcRZwonCZ8ndMYxRNqv6EccAe1H+
 RQhuCNcnrYz4IzOfRRmLq9tb7tvUUa4=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-54-owG9ICKvNd-bs7UszHI3Ig-1; Mon,
 16 Jun 2025 10:44:09 -0400
X-MC-Unique: owG9ICKvNd-bs7UszHI3Ig-1
X-Mimecast-MFC-AGG-ID: owG9ICKvNd-bs7UszHI3Ig_1750085048
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 2A81C19560A3; Mon, 16 Jun 2025 14:44:08 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.11])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 32A54180035E; Mon, 16 Jun 2025 14:44:07 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 710C921E6A27; Mon, 16 Jun 2025 16:44:04 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Chao Liu <chao.liu@yeah.net>
Cc: Chao Liu <lc00631@tecorigin.com>,  pbonzini@redhat.com,
 peterx@redhat.com,  david@redhat.com,  philmd@linaro.org,
 balaton@eik.bme.hu,  qemu-devel@nongnu.org
Subject: Re: [PATCH v7 0/1] Optimizing the print format of the QEMU monitor
 'info mtree'
In-Reply-To: <7b5c0278-e2e9-4632-845b-73bf53c79525@yeah.net> (Chao Liu's
 message of "Mon, 16 Jun 2025 21:45:42 +0800")
References: <cover.1749800810.git.chao.liu@yeah.net>
 <87frg0w7rb.fsf@pond.sub.org>
 <7b5c0278-e2e9-4632-845b-73bf53c79525@yeah.net>
Date: Mon, 16 Jun 2025 16:44:04 +0200
Message-ID: <87h60fd9vv.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -39
X-Spam_score: -4.0
X-Spam_bar: ----
X-Spam_report: (-4.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.892,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

Chao Liu <chao.liu@yeah.net> writes:

> On 2025/6/16 13:55, Markus Armbruster wrote:
>> Chao Liu <lc00631@tecorigin.com> writes:
>>=20
>>> From: Chao Liu <chao.liu@yeah.net>
>>>
>>> Hi, all:
>>>
>>> After several rounds of discussion, I think that adding a -t option to =
the
>>> `info mtree` command, which enables the display of tree-like node chara=
cters
>>> (e.g., +--, |--), is a better approach.
>>>
>>> As BALATON Zoltan pointed out, retaining space-based indentation for di=
splaying
>>> memory region (mr) nodes helps ensure that the output remains easily pa=
rseable
>>> by other programs. This also provides better compatibility with existin=
g tools
>>> and scripts.
>>=20
>> If people really feed the output of HMP info mtree to parsers, we should
>> probably provide the information via QMP.
>
> Thank you for your helpful advice. I think the next step is to try implem=
enting "info mtree" via QMP first, and then have it called by HMP.
>
> I=E2=80=99ve added it to my to-do list, and I=E2=80=99ll try to implement=
 it using QMP in the next phase.

First question before you actually do that: use cases for feeding the
information to programs?  You might have answers already; I'm not on top
of prior conversations.

[...]


