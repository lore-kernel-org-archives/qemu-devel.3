Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6967FC98314
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Sep 2026 07:42:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x9e5W-0000XB-JQ; Thu, 24 Sep 2026 03:41:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1x9e5H-0000VD-St
 for qemu-devel@nongnu.org; Thu, 24 Sep 2026 03:41:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1x9e5F-0001Xe-3N
 for qemu-devel@nongnu.org; Thu, 24 Sep 2026 03:41:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1790235692;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zEErmTVVE5rqQ3ymJkxvB4dNsNFvcpsvExsU9I7YqX8=;
 b=DKxPE0NHHvt4pHTHX4MtAzLxVuTwsKohdVM/CfGE+ZHnMmqD5uj4Mbny74KQcITa2tjlQ+
 p+ENGEW1CS1UvnIdNrJP5nuWJC66tbF84kqlATQk0bpllzbyZjsi3YnZr3R/GPf9Q00ZJB
 lS5tnq80S7HBtyqMC3rvNgsfmsu/Pag=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-412-AwS5T576PBiBdUgVg1ExXA-1; Thu,
 24 Sep 2026 03:41:25 -0400
X-MC-Unique: AwS5T576PBiBdUgVg1ExXA-1
X-Mimecast-MFC-AGG-ID: AwS5T576PBiBdUgVg1ExXA_1790235684
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 4C583187A5D5; Thu, 24 Sep 2026 07:41:24 +0000 (UTC)
Received: from localhost (headnet03.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.114])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 68D8318005B8; Thu, 24 Sep 2026 07:41:23 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH 05/10] hw/tpm: tis: Use uint32_t for len to avoid
 truncating size of command
From: marcandre.lureau@redhat.com
To: Stefan Berger <stefanb@linux.ibm.com>
Cc: qemu-devel@nongnu.org, armenon@redhat.com, marcandre.lureau@gmail.com
In-Reply-To: <20260924012527.858527-6-stefanb@linux.ibm.com>
References: <20260924012527.858527-1-stefanb@linux.ibm.com>
 <20260924012527.858527-6-stefanb@linux.ibm.com>
Date: Thu, 24 Sep 2026 11:41:04 +0400
Message-Id: <179023566486.1794827.16874854647183333335.b4-review@b4>
X-Developer-Signature: v=1; a=openpgp-sha256; l=326;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=96h0qbYWpBd0kFUfBaFxBR6H8HXjV6thdHJew7m0a10=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqtNQT2iO3v1RQL+qGS9Ueb08pHGTo3VJEczje7
 TPen8dBZZqJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCarTUEwAKCRDa6OEJdZac
 5VuDEACmN/2bHLqX2Rs5vq5wkpP8Ei7uCCuQxbGd5iToIKqm2zWWLXA8vk+RMwLmKzdLfcZGIqN
 fUzvhy11Ya5R+9WpjafYKtHpR/AHdiZvjYN6Xn1D9KKpb8PezkSChNzK3ZeYl0CkSbv1vIFQx4/
 px4fdLmuIZpjLxJD2XRzNNmB6Y1ZyVtE5h8H4zc9umDCOYh82UPQuEOX04hhsvqr4F96y+bYn4l
 zu46EK6GNeqAv5QjlAh5B8hGfbw7a3Qwc8VgyD4Cydc3GEC/6Hy32lwISJgDj33HZA6YnOY87qM
 Az/3yqCxz7WRtBjb5jxUAxK5LOB8V3im3PEuY6PhaCELLU36nQeRi2jBcxF2E04wEYds99dGUy1
 mXALQkyQauCqVcdw1hARGfUn34DClYxmAV38al96I17fA6c1QO0s2BdTJaBPP1n2HNPCXH8vHe2
 nFZvb3rmV20NRNl/l/qqE2amgwjp4ux7tytYPmSu8euXHrx8v3aWmNjHEMzoTFPACSBOLtYacvx
 FcKXqSCKChQgy+iDNd2ZAFGC6150xq5+NTfJNprXnvkPD9tG/bhOvhpEun8/DAsfKN8EVKyjn7L
 fp4udWTj1mBj95TAfMcmu7kj31g3CQG4ydL9l81DxRC7N26e6C2ixPZfOhaNNyefZ0xGZ6KWh9v
 8uE01ikl3kfUlKQ==
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

On Wed, 23 Sep 2026 21:25:22 -0400, Stefan Berger <stefanb@linux.ibm.com> wrote:
> To avoid truncating the uint32_t return value from tpm_cmd_get_size()
> declare len as uint32_t rather than uint16_t.

Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>

-- 
Marc-André Lureau <marcandre.lureau@redhat.com>


