Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CDD99CAC5BD
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Sep 2025 06:57:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v37oG-0006sW-Ix; Mon, 29 Sep 2025 02:56:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1v37oE-0006sO-Jz
 for qemu-devel@nongnu.org; Mon, 29 Sep 2025 02:56:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1v37o6-0003ft-Df
 for qemu-devel@nongnu.org; Mon, 29 Sep 2025 02:56:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1759128974;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 resent-to:resent-from:resent-message-id:in-reply-to:in-reply-to:
 references:references; bh=ya2ZjeKqMyBlEfIJG3gRL2TQ4Zi5/Td4YQqqSAYntjA=;
 b=KUTuRBK48trUparpI00T8mqPFTGt1/L2qFtBjYXDWkZUk4uM0AdmuSf6Ksfk96i9VkU/3x
 ffEZ9GckVwfyX9W0ySyLf8EaGTW7smDDMkWlLCwm0Www8GI7Sh5EgXgXoH6h1T7JF513ty
 qs6lLeObVxRgasFs7axrPVWmUNACTI4=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-82-c14mZT0oP1abl1eajFFx2Q-1; Mon,
 29 Sep 2025 02:56:10 -0400
X-MC-Unique: c14mZT0oP1abl1eajFFx2Q-1
X-Mimecast-MFC-AGG-ID: c14mZT0oP1abl1eajFFx2Q_1759128969
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 582951956053; Mon, 29 Sep 2025 06:56:09 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.14])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B8AFC19560A2; Mon, 29 Sep 2025 06:56:08 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 2784921E6A27; Mon, 29 Sep 2025 08:56:06 +0200 (CEST)
Resent-To: zhenzhong.duan@intel.com, qemu-devel@nongnu.org,
 steven.sistare@oracle.com
Resent-From: Markus Armbruster <armbru@redhat.com>
Resent-Date: Mon, 29 Sep 2025 08:56:06 +0200
Resent-Message-ID: <87wm5h927t.fsf@pond.sub.org>
X-From-Line: armbru@redhat.com Mon Sep 29 08:00:06 2025
Received: from imap.gmail.com ([2a00:1450:400c:c1d::6c]:993) by
 dusky.pond.sub.org with IMAP4-SSL getmail6 msgid:11/362461; 29 Sep 2025
 06:00:06 -0000
Received: from blackfin.pond.sub.org (p4fd050ba.dip0.t-ipconnect.de.
 [79.208.80.186]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-46e32bf61b1sm88009965e9.2.2025.09.28.21.32.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 28 Sep 2025 21:32:47 -0700 (PDT)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 4DC7021E6A27; Mon, 29 Sep 2025 06:32:46 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "clg@redhat.com" <clg@redhat.com>,  "eric.auger@redhat.com"
 <eric.auger@redhat.com>,  "steven.sistare@oracle.com"
 <steven.sistare@oracle.com>
Subject: Re: [PATCH 5/5] accel/kvm: Fix SIGSEGV when execute "query-balloon"
 after CPR transfer
In-Reply-To: <IA3PR11MB91367C4C3B50CFCCDDB96C3A9218A@IA3PR11MB9136.namprd11.prod.outlook.com>
 (Zhenzhong Duan's message of "Sun, 28 Sep 2025 08:13:11 +0000")
References: <20250926022540.1884023-1-zhenzhong.duan@intel.com>
 <87v7l5stsj.fsf@pond.sub.org>
 <IA3PR11MB91367C4C3B50CFCCDDB96C3A9218A@IA3PR11MB9136.namprd11.prod.outlook.com>
Date: Mon, 29 Sep 2025 06:32:46 +0200
Message-ID: <875xd1anf5.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-getmail-retrieved-from-mailbox: [Gmail]/All Mail
X-GMAIL-LABELS: "\\Sent"
X-GMAIL-THRID: 1844291735063470039
X-GMAIL-MSGID: 1844571398150629311
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.539,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

"Duan, Zhenzhong" <zhenzhong.duan@intel.com> writes:

>>-----Original Message-----
>>From: Markus Armbruster <armbru@redhat.com>

[...]

>>Is freeing @kvm_state after CPR transfer useful?
>
> kvm_state was NULLed, let me try to keep it for query just like in kernel
> task struct is retained when child process exit.
>
> I'd like to add your Suggested-by on this if you don't object.

I don't :)


