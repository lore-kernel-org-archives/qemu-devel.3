Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CDAD2C531D0
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jul 2026 15:07:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1woMv2-0007cs-Jm; Mon, 27 Jul 2026 11:07:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1woMv0-0007cQ-VR
 for qemu-devel@nongnu.org; Mon, 27 Jul 2026 11:07:02 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1woMuz-0007lh-FJ
 for qemu-devel@nongnu.org; Mon, 27 Jul 2026 11:07:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1785164819;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=/Tf7TYq1TgIWCvYsC7tVfjbjBVlvuB8Mtjwxvh/hUKE=;
 b=iAr0wc6Tg+XlLQ8+pTkh5uuu0GovLtLtySK/ltFKfKVaq1mgCN+pBlZJIkPhOKA/3/MTmv
 Atk4OvTUajCyOqbDC7Kk8M34fCPUgVW4kQKswc8am1sYMXVPDASxSf8DIRjvYsCCMWJJ/c
 XkGRnQkv2aGHTMj5wMs/wzdxOW4EKKQ=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-347-hKxtjImzOLShxkPoe50iSw-1; Mon,
 27 Jul 2026 11:06:57 -0400
X-MC-Unique: hKxtjImzOLShxkPoe50iSw-1
X-Mimecast-MFC-AGG-ID: hKxtjImzOLShxkPoe50iSw_1785164814
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D1A901801A13; Mon, 27 Jul 2026 15:06:53 +0000 (UTC)
Received: from localhost (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 06CE61956041; Mon, 27 Jul 2026 15:06:52 +0000 (UTC)
From: Cornelia Huck <cohuck@redhat.com>
To: Christian Borntraeger <borntraeger@linux.ibm.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, qemu-s390x <qemu-s390x@nongnu.org>,
 Halil Pasic <pasic@linux.ibm.com>, Matthew Rosato
 <mjrosato@linux.ibm.com>, Eric Farman <farman@linux.ibm.com>, Jason Herne
 <jjherne@linux.ibm.com>, Richard Henderson <richard.henderson@linaro.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>, David Hildenbrand
 <david@kernel.org>, Hendrik Brueckner <brueckner@linux.ibm.com>, Joshua
 Daley <jdaley@linux.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>, Jared
 Rossi <jrossi@linux.ibm.com>, Zhuoying Cai <zycai@linux.ibm.com>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Subject: Re: [PATCH 0/5] more hardening fixes for s390
In-Reply-To: <49089127-7189-4bdc-bbf9-5a3ecdc99659@linux.ibm.com>
Organization: "Red Hat GmbH, Sitz: Werner-von-Siemens-Ring 12, D-85630
 Grasbrunn, Handelsregister: Amtsgericht =?utf-8?Q?M=C3=BCnchen=2C?= HRB
 153243,
 =?utf-8?Q?Gesch=C3=A4ftsf=C3=BChrer=3A?= Ryan Barnhart, Charles Cachera,
 Avril Crosse O'Flaherty"
References: <20260727115052.24289-1-borntraeger@linux.ibm.com>
 <87ldawsk8a.fsf@redhat.com>
 <49089127-7189-4bdc-bbf9-5a3ecdc99659@linux.ibm.com>
User-Agent: Notmuch/0.40 (https://notmuchmail.org)
Date: Mon, 27 Jul 2026 17:06:50 +0200
Message-ID: <87fr14sc8l.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=cohuck@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -36
X-Spam_score: -3.7
X-Spam_bar: ---
X-Spam_report: (-3.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.58,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Mon, Jul 27 2026, Christian Borntraeger <borntraeger@linux.ibm.com> wrote:

> Am 27.07.26 um 14:14 schrieb Cornelia Huck:
>> On Mon, Jul 27 2026, Christian Borntraeger <borntraeger@linux.ibm.com> wrote:
>> 
>>> Cornelia, Eric, Matt,
>>>
>>> here are 5 more fixes for hardening QEMU against invalid input. Nothing
>>> is strictly a security issues as defined in the policy. For example
>>> https://qemu-project.gitlab.io/qemu/system/security.html says assert /
>>> abort: If triggering the code path requires kernel privileges (or root
>>> account access) in the guest, asserts/aborts in QEMU are a self
>>> inflicted denial of service. These will not be treated as security
>>> flaws, at most hardening bugs.
>>> And if anyone can provide invalid boot loader content it can provide
>>> anything to boot if secure boot is not available.
>>> We should fix those anyway, probably even for 11.1
>> 
>> Fixing: yes. For 11.1: how easy are they to trigger? For the bios fixes,
>> I assume you need a broken/crafted disk image; I assume that for the
>> other two, you need some buggy/misbehaving guest. Did you actually
>> manage to trigger this via some kind of test case?
>
> Easy to trigger, but only with modified guests or modified zipls. Normal
> guests will not trigger those.

Ok, so I think these would be suitable for the next release, but maybe
with a cc:stable.


