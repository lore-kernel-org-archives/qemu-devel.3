Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0780FCA5FDD
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Oct 2026 17:28:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xCgzq-0005x3-DE; Fri, 02 Oct 2026 13:24:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1xCgy3-0000XC-2q
 for qemu-devel@nongnu.org; Fri, 02 Oct 2026 13:22:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1xCgxu-0003me-L9
 for qemu-devel@nongnu.org; Fri, 02 Oct 2026 13:22:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1790961754;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=EEhqnm3EOmM9eVr8GLVonlTQqlbVQbBXp3m1BlQx9GY=;
 b=JPZouRk8GBzt3QulXM5aEDBY1yKMqL4I1+MxXH84eie3+VIopiXYuBM9kB71FsjdhksYJX
 OTSKhcQPjSeb+NiDKgyHkrAwUNc4lWOqlcdw/A2F7XkjAHfmiKQs5uoOsSbp8HfclbWAi7
 w+TKpJr0MRj63422rVeTaIrLcnwj6ng=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-558-p1TWn7s_PYW4Ecdwm5PBsw-1; Fri,
 02 Oct 2026 13:22:33 -0400
X-MC-Unique: p1TWn7s_PYW4Ecdwm5PBsw-1
X-Mimecast-MFC-AGG-ID: p1TWn7s_PYW4Ecdwm5PBsw_1790961751
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 8A0511933B54; Fri,  2 Oct 2026 17:22:31 +0000 (UTC)
Received: from localhost (headnet03.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.114])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 9F4E930000E4; Fri,  2 Oct 2026 17:22:30 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH 24/28] hw/acpi: mark erst, vmclock and vmgenid devices
 as secure
From: marcandre.lureau@redhat.com
To: =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, xen-devel@lists.xenproject.org, 
 qemu-riscv@nongnu.org, qemu-ppc@nongnu.org, qemu-block@nongnu.org, 
 qemu-s390x@nongnu.org, qemu-arm@nongnu.org
In-Reply-To: <20260911143627.2743803-25-berrange@redhat.com>
References: <20260911143627.2743803-1-berrange@redhat.com>
 <20260911143627.2743803-25-berrange@redhat.com>
Date: Fri, 02 Oct 2026 21:21:01 +0400
Message-Id: <179096166135.3025252.5276440234709859311.b4-review@b4>
X-Developer-Signature: v=1; a=openpgp-sha256; l=311;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=Fc4JGWriNlh1aGVhw+L3RaNahMSkAov3VpkIEc3qsrs=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqv+gCFZNQTLJcghDdZduMRhYInrKRZN96owzBZ
 NuUAnHSWY+JAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCar/oAgAKCRDa6OEJdZac
 5RzhD/9IzWE0cq3SuUd3EvzJ9eyA4wNfZNMJWR3MfNxrIVYKPWMzF3n5Ozxwp7as/uktUWP7keG
 27P6I3tMsqrwpKUqAyq8CUsLW6XpA3bmM8Psp6KqQuiarvkJsYwwF5P7lC3I6SUlLvQql97plz4
 pQYiSAVmOUbewFfE0CfSkUCBwSJ0zN4qDliK+Uh0DIBs37h3zk4Sylpi2vFHo/MTrARoRyvoUT2
 NFyqRHrua1vj8NEaJtm8c4TLSUjDmFmcFuQ7aylb/0y/qz+VLIiYjzXiQ0dqESzSEj9ppZBG+XP
 8QjRjm3JNpKLhB8T4Aya+tNsqp7nhSvBbEAFKPh2n5iRAFYDKxWWEQTPV9BhbSjJ0UmXvILoVer
 fP2ML12qnHwidx9UELRuyMyIYVBabAVK5yvs5e9BcYjDlLTw0WY6rCoynLw6gJjck/7/nJB9Apn
 Dqfftm/va4YSeTAgiZlteU4D+u6Hg+Z3+0BAvSP18gRKHUhQijkpDBSh/zTc+OR3+mC27ltQHV5
 F9hhTzu0MzGpnJ45tkqI6vzH9O322zY6uSoMM+7kI5Z9R8ISBolwOC3q/fa/OZl38TKe+qtFkVp
 qwSBKQ8TWddFtAhUuwcgwb1eFI+wU48t79BwshaZMo+AfGPlrcFJ9xIFpiWUsynnnK7w2o6lFfL
 o2HeHPy3X+P8Icg==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 9
X-Spam_score: 0.9
X-Spam_bar: /
X-Spam_report: (0.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.336,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On Fri, 11 Sep 2026 15:36:23 +0100, Daniel P. Berrangé <berrange@redhat.com> wrote:
> These are all used in virtualization scenarios so must be
> declare to provide a security boundary

Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>

-- 
Marc-André Lureau <marcandre.lureau@redhat.com>


