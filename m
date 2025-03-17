Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 093C5C28B30
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Mar 2025 15:33:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tuCSF-0005T8-CR; Mon, 17 Mar 2025 11:32:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1tuCS1-0005RV-KR
 for qemu-devel@nongnu.org; Mon, 17 Mar 2025 11:32:27 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1tuCS0-0004pA-4H
 for qemu-devel@nongnu.org; Mon, 17 Mar 2025 11:32:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1742225543;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=k6AP8qPgf7yOre7jra69M1oGbFQiEjvBM1isV3S1yxw=;
 b=ikweImA7D0948f6l5J4kqxcwLk5IBReHFbXur9JGqpmxjLwkCzbqeGpjYnEBkKVUFXjnPv
 uQ53nEcq5QxH6sysJhI/Qq+WLzDosQzOuwtOr41dpG3D8BwCM0F2ZZ0rjRiyt9ApHEoSCh
 ceOELy43+xDcJrAOmTbQU+839NK9sd0=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-79-rZ07XL0XNsqRgktiRCcYpg-1; Mon,
 17 Mar 2025 11:32:17 -0400
X-MC-Unique: rZ07XL0XNsqRgktiRCcYpg-1
X-Mimecast-MFC-AGG-ID: rZ07XL0XNsqRgktiRCcYpg_1742225534
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A6D9A180AF4D; Mon, 17 Mar 2025 15:32:13 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.22.74.4])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 5F423180094A; Mon, 17 Mar 2025 15:32:12 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 4355821E675E; Mon, 17 Mar 2025 16:32:08 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,  Anthony PERARD
 <anthony.perard@vates.tech>,  qemu-devel@nongnu.org,  qemu-ppc@nongnu.org,
 Yoshinori Sato <ysato@users.sourceforge.jp>,  Paul Durrant
 <paul@xen.org>,  Peter Xu <peterx@redhat.com>,  alex.bennee@linaro.org,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,  David Hildenbrand
 <david@redhat.com>,  Alistair Francis <alistair.francis@wdc.com>,  Richard
 Henderson <richard.henderson@linaro.org>,  "Edgar E. Iglesias"
 <edgar.iglesias@gmail.com>,  Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Nicholas Piggin <npiggin@gmail.com>,  Daniel Henrique Barboza
 <danielhb413@gmail.com>,  qemu-riscv@nongnu.org,
 manos.pitsidianakis@linaro.org,  Palmer Dabbelt <palmer@dabbelt.com>,
 kvm@vger.kernel.org,  xen-devel@lists.xenproject.org,  Stefano Stabellini
 <sstabellini@kernel.org>,  Paolo Bonzini <pbonzini@redhat.com>,  Weiwei Li
 <liwei1518@gmail.com>,  Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PATCH v5 00/17] make system memory API available for common code
In-Reply-To: <3ce90214-a080-4ae8-86ff-9f8fd20f1733@linaro.org> ("Philippe
 =?utf-8?Q?Mathieu-Daud=C3=A9=22's?= message of "Mon, 17 Mar 2025 10:21:00
 +0100")
References: <20250314173139.2122904-1-pierrick.bouvier@linaro.org>
 <5951f731-b936-42eb-b3ff-bc66ef9c9414@linaro.org>
 <Z9R2mjfaNcsSuQWq@l14>
 <ee814e2f-c461-4cc2-889d-16bb2df44fdf@linaro.org>
 <3ce90214-a080-4ae8-86ff-9f8fd20f1733@linaro.org>
Date: Mon, 17 Mar 2025 16:32:08 +0100
Message-ID: <87h63rekqv.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.335,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org> writes:

> Hi,
>
> On 14/3/25 19:39, Pierrick Bouvier wrote:
>> On 3/14/25 11:34, Anthony PERARD wrote:
>>> On Fri, Mar 14, 2025 at 10:33:08AM -0700, Pierrick Bouvier wrote:
>>>> Hi,
>>>>
>>>> one patch is missing review:
>>>> [PATCH v5 12/17] hw/xen: add stubs for various functions.
>>>
>>> My "Acked-by" wasn't enough? Feel free try change it to "Reviewed-by"
>>> instead.
>>>
>> Those are differents. From what I understand, Reviewed implies Acked, bu=
t the opposite is not true. If it was, they would be equivalent.
>> Thanks.
>
> IIUC on QEMU Acked-by means "as a maintainer of files modified by
> this patch, I don't have objection on my area, as long as someone
> else takes the patch". It doesn't mean the patch has been reviewed.
>
> Please correct me if I'm wrong.

Documentation/process/submitting-patches.rst has some advice, but not
much.  Kernel docs are more thorough, and I believe the information
there applies to QEMU reasonably well:

https://docs.kernel.org/process/5.Posting.html#patch-formatting-and-changel=
ogs


