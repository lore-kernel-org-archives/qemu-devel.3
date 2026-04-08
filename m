Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52C4310F9972
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Apr 2026 19:11:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wAYI4-0006ek-S8; Wed, 08 Apr 2026 15:10:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <matt@matthewpenney.net>)
 id 1wAYGU-0003xI-1j
 for qemu-devel@nongnu.org; Wed, 08 Apr 2026 15:08:43 -0400
Received: from mail-4398.protonmail.ch ([185.70.43.98])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <matt@matthewpenney.net>)
 id 1wAHIt-0001Kc-Ea
 for qemu-devel@nongnu.org; Tue, 07 Apr 2026 21:02:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=matthewpenney.net;
 s=protonmail; t=1775610106; x=1775869306;
 bh=c6LsDDWHxl+IyeJwtRxPcY/p2JWwdDpKFKOdY0l8OZs=;
 h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
 b=Dz7WnsoX4a2myS53oVBkHio95IPDwV1Yw0jeRHkMQBx5aw9Sc6OkxksM0XC8xvc9s
 oxCdojP0FNSABvQkhVQKLn39M4GHwysTzBO9NSaZL+yRu7/avEATUKnX++9+DV+c2k
 K2uE/SueR87LNM5rx01ExczjsZSe6AJTB2MjCUemqEIZ8RrtUvsVNT5sNDm1h0uETr
 o9Ia1xiRcIXArztkMPmZL4oqLasIyLAGRFZfnt4I6UsVdo7reIIZeBsJGsBNlvDiZX
 t/F2Y4TS7uerxideg+MhvC/nvf5dnRhJdeDSe3Wcf+BZQUQDMarRG0Um05wpleETgS
 +yQTrxyEbcp0A==
Date: Wed, 08 Apr 2026 01:01:42 +0000
To: qemu-devel@nongnu.org
From: Matthew Penney <matt@matthewpenney.net>
Cc: Matthew Penney <matt@matthewpenney.net>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?utf-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Joel Stanley <joel@jms.id.au>,
 "Michael S. Tsirkin" <mst@redhat.com>, Samuel Tardieu <sam@rfc1149.net>,
 Cornelia Huck <cohuck@redhat.com>, Eric Farman <farman@linux.ibm.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>, Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 "Collin L. Walling" <walling@linux.ibm.com>,
 Laurent Vivier <lvivier@redhat.com>, Amit Shah <amit@kernel.org>,
 qemu-arm@nongnu.org, qemu-s390x@nongnu.org,
 =?utf-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Jason Wang <jasowang@redhat.com>, Stefano Garzarella <sgarzare@redhat.com>,
 Fam Zheng <fam@euphon.net>, qemu-block@nongnu.org,
 Marcelo Tosatti <mtosatti@redhat.com>, kvm@vger.kernel.org,
 Zhao Liu <zhao1.liu@intel.com>
Subject: [PATCH 0/8] tree-wide: use g_clear_handle_id() for GSource cleanup
Message-ID: <20260408010026.4611-1-matt@matthewpenney.net>
Feedback-ID: 185185778:user:proton
X-Pm-Message-ID: 0b93e9d6492d44ac673aedfdd8598211ff563d8e
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=185.70.43.98; envelope-from=matt@matthewpenney.net;
 helo=mail-4398.protonmail.ch
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

This series replaces open-coded uses of g_source_remove() with
g_clear_handle_id() across the tree.

This is a more modern (GLib >=3D 2.56) approach than directly calling
g_source_remove().

g_clear_handle_id() simplifies cleanup of GSource IDs since it
checks the ID is valid, calls the cleanup function and zeros the ID.

This reduces boilerplate and avoids open-coded calls to
g_source_remove().

This series follows an earlier fix that removed a dangling GSource tag
and replaced an explicit call to g_source_remove() with
g_clear_handle_id().

No functional changes.

Link: https://gitlab.com/qemu-project/qemu/-/commit/34aad589019c8687fb3b19b=
a79d64d97071a7205

Signed-off-by: Matthew Penney <matt@matthewpenney.net>


