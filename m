Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5D4A606A320
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Nov 2026 11:27:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=taktcycles.com header.i=@taktcycles.com header.a=rsa-sha256 header.s=takt1 header.b=KytlvZJ9
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xTdp1-0001AB-P2; Wed, 18 Nov 2026 06:27:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rdmitry@taktcycles.com>)
 id 1xTdp0-00019v-E0
 for qemu-devel@nongnu.org; Wed, 18 Nov 2026 06:27:26 -0500
Received: from mail.taktcycles.com ([136.243.71.244])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rdmitry@taktcycles.com>)
 id 1xTdoy-0007rO-Rz
 for qemu-devel@nongnu.org; Wed, 18 Nov 2026 06:27:26 -0500
Received: from mail.taktcycles.com (unknown [192.168.64.27])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (3072 bits) server-digest SHA256)
 (No client certificate requested)
 by relay.taktcycles.com (Postfix) with ESMTPSA id BC0A5888A;
 Wed, 18 Nov 2026 11:27:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=taktcycles.com;
 s=takt1; t=1795001241;
 bh=uE/0Y7fBZXA0gkRW42jK8D6M72IjSXW8QlyxGwvKu9k=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=KytlvZJ9tVannJkcObg0gkpuVJDLdFwlwWzsNXsR0/PtlaLr44ba3HWs+h+2gIPaK
 YFDOKRsPx7piiUEtTAfvo24KTQKNFS4cv9/rCLTkikdXMzaBxeqf/dFYoZDnnRJu8s
 GkjSSuKWvw3vP7cZ8gprneRirikVUJc/ro3pE9ZVtAeDUxqmlM8J7kqOXvIPVgBP2l
 9afR5mnoHbTnBzMEzpktLrWWKtUpQfIBXgRtn4KvhqDicXUMv+rxZ790ltiyQTAQAJ
 hfWhQGbxhfYU+Me16PRMzdGN3JB4SyfAf6PtTyRAlwhaccTOnljtyOhXi93ARLPvJO
 euKpwCg8MmKWA==
Received: from [192.168.64.27] (localhost [127.0.0.1])
 by mail.taktcycles.com (Postfix) with ESMTP id 519E820201;
 Wed, 18 Nov 2026 11:27:21 +0000 (UTC)
From: Dmitry R <rdmitry@taktcycles.com>
To: =?utf-8?q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Cc: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>, qemu-devel@nongnu.org,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>,
 Alex =?utf-8?q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>
Subject: Re: [PATCH v3 4/8] hw/display/vhost-user-gpu: reset scanouts on the
 main loop
Date: Wed, 18 Nov 2026 11:26:10 +0000
Message-ID: <179500117014.3846346.14056280198689614585@taktcycles.com>
In-Reply-To: <CAMxuvaxDU0K_w5kQfm6UnGskM=zs=ie_uUYbVWVhwMko=ypVTg@mail.gmail.com>
References: <20261113-issue-4848-v3-0-98e4fa3e77eb@redhat.com>
 <20261113-issue-4848-v3-4-98e4fa3e77eb@redhat.com>
 <23ed503d-01ed-4ef4-96d2-e31ca00d4bd9@rsg.ci.i.u-tokyo.ac.jp>
 <CAMxuvaxDU0K_w5kQfm6UnGskM=zs=ie_uUYbVWVhwMko=ypVTg@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Received-SPF: pass client-ip=136.243.71.244;
 envelope-from=rdmitry@taktcycles.com; helo=mail.taktcycles.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Marc-André, Akihiko,

On Sun, 15 Nov 2026 11:58:52 +0400, Marc-André Lureau wrote:
> Could you fix vhost-user-gpu in the same series?
>
> Should we review & merge your series before this one?

From the testing side, I should clarify the scope of my earlier
Tested-by for v3 in light of Akihiko's comments on 2/8-4/8.

My November 13 tests covered the original four reported failures,
stop/cont, guest boots and resets with a D-Bus listener attached,
including five consecutive system_reset/boot cycles, and finalization
of never-realized instances. They did not race a guest-initiated reset
with QMP stop/cont, or stop the control queue while GET_DISPLAY_INFO or
GET_EDID was waiting for the frontend's reply. The passing results do
not cover those two cases raised on 2/8 and 4/8.

For 3/8, the GL cleanup on the vCPU thread is the same path that caused
the D-Bus tex_id assertion in my v1 testing. Folding 3/8 and its main-loop
fix together makes sense so the intermediate commit is usable too.

Thanks for catching these gaps. I can retest the follow-up once the
reset changes are settled, including the reset/stop race and stopping
the control queue with a frontend reply pending.

Dmitry

