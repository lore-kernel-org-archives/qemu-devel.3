Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A84ACCF2C7
	for <qemu-devel@archiver.kernel.org>; Sat, 17 Oct 2026 08:45:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xI00n-0001RI-AL; Sat, 17 Oct 2026 04:43:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1xI00l-0001Qt-CP
 for qemu-devel@nongnu.org; Sat, 17 Oct 2026 04:43:27 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1xI00j-0007AS-UU
 for qemu-devel@nongnu.org; Sat, 17 Oct 2026 04:43:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1792226605;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=NAzeuHM+VyMPPnZlbPdDnL2pvP+W/YN6GDKSt6xtl2M=;
 b=B48iwloDmSFmaGCE4YXrN53z8JXgSBur455uBNbtJkPBNuVMqYrxiVpfkMzAYh4IIRru83
 ff7j3NzV1z61rlc8bNjI6IK2DncgEtBVjBf0+Lo9chA4KXq0RYVMQyztdLQM5RitRxk70I
 tHb8nUpVPTfQjT3pKhlE5j73goKYfcc=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-42-e7HI-PYjN6yol2GWFvCJww-1; Sat,
 17 Oct 2026 08:43:21 +0000
X-MC-Unique: e7HI-PYjN6yol2GWFvCJww-1
X-Mimecast-MFC-AGG-ID: e7HI-PYjN6yol2GWFvCJww_1792226600
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 4FF081800A37; Sat, 17 Oct 2026 08:43:20 +0000 (UTC)
Received: from localhost (headnet05.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.117])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 341621956087; Sat, 17 Oct 2026 08:43:18 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v3 07/23] target/i386: implement get_dump_info sysemu
 op
From: marcandre.lureau@redhat.com
To: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 anjo@rev.ng, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20261016181410.191743-8-pierrick.bouvier@oss.qualcomm.com>
References: <20261016181410.191743-1-pierrick.bouvier@oss.qualcomm.com>
 <20261016181410.191743-8-pierrick.bouvier@oss.qualcomm.com>
Date: Sat, 17 Oct 2026 12:42:48 +0400
Message-Id: <179222656898.1619676.13937749718677808670.b4-review@b4>
X-Developer-Signature: v=1; a=openpgp-sha256; l=284;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=Ju2ZpXECVtwvicfczEWjIyJR/TeMWFuOFJfQJKOVcUE=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBq0zUM00IRFoDGCboe16vcWNZ2FT8+jph/EfToy
 2oP++oYUG+JAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCatM1DAAKCRDa6OEJdZac
 5cTeD/0f3w7MI4tZupvTTYI4p+9NxNdr9oTvWuEkDxe7e8ogyvWCe1tdDG7pV/tDCAuSQSY7iHX
 UPc/S06R+zHg+v7x7qBRBQM0n0uUQrCO1YHWYgzUvT4uvqqyjvS6bmcmBfqTBc7LXxcYCtt5Zoq
 iPdG0bSV270cuKYluBLO89Tox24hGUkC/7yNgIdH/sbaRwp4IoR0yhHupSStkTpDGfSfJi8T7W+
 RVLLZNKKo5UAdRuUMMsXkX0xatOmynvO6q2xr4w7O5nshldvuIe0PT2VEaYAu1HQnyW7Ejlh2P6
 eO4dNuH5XdTwV7vxUIzE1458wFr0h2VOPQrUfaF9Lx6q9o3TLzV3boARRAf28UaN+6BTzMPBCuD
 +lnU5OFhxLM/XrR46O31lg5gTY5nXqRtKS61h1+RSv/6kOGXEjruKDpuWrDQztrm1U22L3wnhg0
 7jjg+TCz5tGUDPn2Lv6ieJMWAMI3lodEaddzRdaZhXf3iQJQh3oSHJ3X1WvxT6tuIv92wdme7yj
 Bab3CUI60Rrj9IaBtbQzFd+x7qXVo+/XGjMXl/JPgEupikGGs9UR0gJQVANYh0kUopS2IQmFvLe
 TSRGNZ7Yaw5TQFt3SRoChkOtMDwMda8cC2gEnHXKvQFYm/dBRz/omJFkB0uan6eY6AmgvkSvGl1
 f4b+fweKz8nAWnQ==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.24,
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

On Fri, 16 Oct 2026 11:13:54 -0700, Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com> wrote:
> For now, we keep the global cpu_get_dump_info symbol defined.

Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>

-- 
Marc-André Lureau <marcandre.lureau@redhat.com>


