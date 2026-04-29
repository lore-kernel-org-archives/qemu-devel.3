Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5717FF8875
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2026 19:37:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wIAiS-0004Y6-7P; Wed, 29 Apr 2026 15:37:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wIAiP-0004Xh-FJ
 for qemu-devel@nongnu.org; Wed, 29 Apr 2026 15:36:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wIAiN-0001ic-Qz
 for qemu-devel@nongnu.org; Wed, 29 Apr 2026 15:36:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1777491413;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=QiQT6EaomKpfclHTRSqeQ+HtYaOHXExQKumyJQ3/YO0=;
 b=AJt/MtEW9ag5j5rdLG7uBNbE8fjPAqQeJXRfG9NTLP1nbSL1lQ+aIVpAb27wK7cPDhECxl
 gj7lD4NMsojIKjjAhYfaGRs/Tj+36HzIFrujlCJjGVdwsNYFAY9BTy91vV08LDsFkNc4RM
 Agfa1sBbOn1Q4DJ/H/ids3SBHG5mtn4=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-272-wGomcFZ3NoSP4fLL_6LLDw-1; Wed,
 29 Apr 2026 15:36:52 -0400
X-MC-Unique: wGomcFZ3NoSP4fLL_6LLDw-1
X-Mimecast-MFC-AGG-ID: wGomcFZ3NoSP4fLL_6LLDw_1777491411
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 4E70D180049F; Wed, 29 Apr 2026 19:36:51 +0000 (UTC)
Received: from localhost (unknown [10.44.22.2])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id DEBCA180045E; Wed, 29 Apr 2026 19:36:49 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v1 0/5] tests/qtest: Re-enable dbus-vmstate
From: marcandre.lureau@redhat.com
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, Peter Xu <peterx@redhat.com>, 
 marcandre.lureau@redhat.com
In-Reply-To: <20260429190550.20122-1-farosas@suse.de>
References: <20260429190550.20122-1-farosas@suse.de>
Date: Wed, 29 Apr 2026 23:36:40 +0400
Message-Id: <177749140089.618480.3954142082531190748.b4-review@b4>
X-Developer-Signature: v=1; a=openpgp-sha256; l=428;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=IgwWfNpW8hvV4T3BTRc9boE6xUzW4a/wM1TEw4omnA0=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBp8l3KiiN4mrHpd0MbDsnn5Y6m5P7K0533bYWQS
 xeQDwk+qhaJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCafJdygAKCRDa6OEJdZac
 5dXeD/4uY4PbcA4ycNgDTE7I324uiU7w8GNB53UKP9KZ1l9q6rSbRTVei0sC/KWso510kfjP0y4
 BY1e/CCvJgw+q3ec1K4a5loNM51onHB4qM5R6RdTahrmFKw8ljR0/65IcQxXVniQnYtqpuVmpLK
 DWyM2rc+GXgfr3Klja2VylcKyMbcAcW2STiZVxjVAgBMcrgWIwLSlDnl0HOAJzBnri18I/XYKnz
 6IFyn+jfiehTnznxk/+QrBaIy56y42OKwEl0MUn8L1FY6RNcEPjqWWAYyir2v5BUGCH4OS1EZ9B
 uOp95i/sFwDFPQXyDm/NQvLYj8XKwlEVFwyThmNZdU/cBERr1wDTnyx0nlk+ZpwRapmrj16Ovud
 R+CDV7MMy58psL+eVp8NyqLQOvlzSK173JTCv5s27HCsntZV/M1SwbVHWQqAV6Bs74m7pm4mf1T
 xeYdpdvQ6tqfN+cROxY9vdDYp1YvcjLL24zmYvbe5beWthqTSTTBpsCnI9Eticqk+OvsUXdesJp
 wfo1TYjKbLtsnDONKRFlNkgav3WDBAR266ERFFnsb5aCH5+nxDPllxF+fcjmxMJF3tdram+jYGE
 gXMrrETkQcsm6pf/rciIwqMYXj0dj3vPj/aPgSUQQnceGc6dtnkSqfzPegm7bLfNYf1z77MdPwd
 ulBzz1R98HghiSA==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Wed, 29 Apr 2026 16:05:45 -0300, Fabiano Rosas <farosas@suse.de> wrote:
> [...]
>  tests/qtest/dbus-vmstate-test.c | 121 ++++++++++++++++++++------------
>  tests/qtest/meson.build         |  10 +--
>  2 files changed, 84 insertions(+), 47 deletions(-)
> 
> --
> 2.51.0

Awesome, many thanks!

Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>

-- 
Marc-André Lureau <marcandre.lureau@redhat.com>


