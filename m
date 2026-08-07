Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F77AC5AC80
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Aug 2026 11:14:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wsIW7-0003HA-Fs; Fri, 07 Aug 2026 07:13:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wsIW6-0003Gs-Ew
 for qemu-devel@nongnu.org; Fri, 07 Aug 2026 07:13:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wsIW4-0007yW-MG
 for qemu-devel@nongnu.org; Fri, 07 Aug 2026 07:13:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1786101208;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jZYEDAPBuR7zt+w+yn++LYr2AjG9cR53DqVz1TFIlwc=;
 b=CiRj5KLwGVOTTNeSF3HYEPPR+LBdzkx7srcNBbafeUQNcslXBc8INCRzMNZdChb7dnKgeu
 R5Z4el8jAXD84f3P8BPgCJa7THy+50ez98HtAdKlO0Z6ctAr9rQkag+v2KZqi0tFevixZc
 G3KNqdhDLqFpe/4R9azDwoqjBRy4Tjo=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-132-EeaswpyRM9-aHfHE5QCxfA-1; Fri,
 07 Aug 2026 07:13:23 -0400
X-MC-Unique: EeaswpyRM9-aHfHE5QCxfA-1
X-Mimecast-MFC-AGG-ID: EeaswpyRM9-aHfHE5QCxfA_1786101202
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 2DC0D1800643; Fri,  7 Aug 2026 11:13:22 +0000 (UTC)
Received: from localhost (unknown [10.47.238.100])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 6AFCF1800348; Fri,  7 Aug 2026 11:13:19 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH 0/3] virtio-gpu: Handle empty and failed udmabuf mappings
From: marcandre.lureau@redhat.com
To: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Cc: qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>, 
 =?utf-8?q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>, 
 Dmitry Osipenko <dmitry.osipenko@collabora.com>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
In-Reply-To: <20260807-dmabuf-v1-0-d24b1331dc8a@rsg.ci.i.u-tokyo.ac.jp>
References: <20260807-dmabuf-v1-0-d24b1331dc8a@rsg.ci.i.u-tokyo.ac.jp>
Date: Fri, 07 Aug 2026 15:13:15 +0400
Message-Id: <178610119592.1593099.7866348372753704123.b4-review@b4>
X-Developer-Signature: v=1; a=openpgp-sha256; l=530;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=UFlGdNn4/ZZrmv9ivAyJeQPYSpZxA1RHpsgd7gAkkzs=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqdb3M3MWgrbC04xQZEIk2MlWfi65eH6u48Yfet
 SfcvpUcc/WJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCanW9zAAKCRDa6OEJdZac
 5RQtEACBiKp7jP6ZjhE1+EKgEllyomGgP0RdP4oO1hN5vQUveUKNBfPv3Tz8ecGni7IAix6PKiP
 hljbt+iwbksLHFADp5LZc36B0fTN5aBV8mA6P2Ne5dPXGXdevfCq7YkomZxRjRAr1WpKN4efYjU
 2/kBevGw0fkMPOmp3vXTFmsjGYziWZjW1oJpQBoHYc+ZApe9n0Pi3S1b2KTipL4YjFRmv06oLl7
 tiJK+jufyifP4vzDtLUv0mPI+g8xb96MsBzGcFO0Ay39XCJgamZzOjuMyiDv/F197MuZA4UEH0f
 NIWzGJIe7TtsLPI0Jt89dMrRAjUB83yTTkDocZpSZSoNSq8WvOliU9fNKI+lINzCdbya5mo9g32
 9x0ow/z3hzDeX3zOqNY8K0D1iNanA923qwMXMKbBnzsl89BQZ6tI0SBSFCUEJEmsOO9WCZOSjvk
 Q71pAAetp1cDrMRO4jREdOOws+cPknUGI2lehfT41k+Z77cIF3CjUH21eSlguyqBqpV/LjpPMrp
 5gfLaSGm6B7+bQWjkkhWoGGfg18Yu140GNw9MWCsCy6ANbPRZcrCEkFeA/TQuD6OnvqWJJRe2aJ
 3mhkQ7MJPUmsO5DxYSWjdcvqf0PuRqzQJRpy0w+9REsbCgvW8QTMxH9VKRZK2XKRVYZ0JxkUn05
 VDryVI60xAkWocQ==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -32
X-Spam_score: -3.3
X-Spam_bar: ---
X-Spam_report: (-3.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.238,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Fri, 07 Aug 2026 14:20:03 +0900, Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp> wrote:
> virtio-gpu: Handle empty and failed udmabuf mappings
> 
> Virtio blob resources may be created without backing and may also have a
> zero size. These valid cases currently reach UDMABUF_CREATE_LIST or
> mmap() with empty inputs, producing EINVAL warnings even though no host
> mapping is required.
> 
> [...]

Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>

-- 
Marc-André Lureau <marcandre.lureau@redhat.com>


