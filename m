Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78F64CDE002
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jun 2026 08:57:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wcJPH-00081p-Nh; Wed, 24 Jun 2026 04:56:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wcJPB-00081A-Hj
 for qemu-devel@nongnu.org; Wed, 24 Jun 2026 04:56:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wcJP9-00074f-Ur
 for qemu-devel@nongnu.org; Wed, 24 Jun 2026 04:56:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1782291378;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5sTuJEUKEo6aGeHUYJdIOCoZpQIoS9OQDYw/6HvYoIc=;
 b=ItF1Jytj27i/H35Vd3qj//ygULKAczT1AP3ZzfRclgRwWy/pGYtjuQN/xVszxBH2mthaxj
 DIE/jQJ+SaZEdzMJdE8J5AKGUYaCURLekXpcm79lolTod3HYSST0op8xmjM3k5/Ut9O6Fx
 mzOh0FTCVzInlkZMn3+ryto2E3t8Dac=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-649-PZtNPb28NGiZIjCR9uq7zA-1; Wed,
 24 Jun 2026 04:56:17 -0400
X-MC-Unique: PZtNPb28NGiZIjCR9uq7zA-1
X-Mimecast-MFC-AGG-ID: PZtNPb28NGiZIjCR9uq7zA_1782291376
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 35E28180064A; Wed, 24 Jun 2026 08:56:16 +0000 (UTC)
Received: from localhost (unknown [10.44.24.16])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 8BE621772; Wed, 24 Jun 2026 08:56:13 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH 3/3] virtio-gpu: use unsigned shift for scanout bitmask
 operations
From: marcandre.lureau@redhat.com
To: Bin Guo <guobin@linux.alibaba.com>
Cc: alex.bennee@linaro.org, mst@redhat.com, odaki@rsg.ci.i.u-tokyo.ac.jp, 
 dmitry.osipenko@collabora.com, qemu-devel@nongnu.org
In-Reply-To: <22d21cfbe4466c27e33e979717957f48673d4647.1782270919.git.guobin@linux.alibaba.com>
References: <cover.1782270919.git.guobin@linux.alibaba.com>
 <22d21cfbe4466c27e33e979717957f48673d4647.1782270919.git.guobin@linux.alibaba.com>
Date: Wed, 24 Jun 2026 12:55:55 +0400
Message-Id: <178229135573.323593.16126794247031686234.b4-review@b4>
X-Developer-Signature: v=1; a=openpgp-sha256; l=675;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=IzQBq/I3ufXzFci+X8rTnE59ExBwBNwKLbJgLv/Upoc=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqO5ue8OZ7lNF7gXmfFHsBYOb7mLuAFIFslNtxt
 4I1UcqGfCmJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCajubngAKCRDa6OEJdZac
 5ZN8D/0Ug4RJ4mrJ/aH16KPaPN6ZKzk6PPonHWxsdWYDWcuWWThsG4Xi0Y1K0WVFM6Qx9VNsIZx
 fjeC9T+6ozR2ShCHBZhcRQ9yy1P+QZ/ODCn7ZBhLRQt9gX4ceKNzajuvd6eO3DsoLctAQS819/S
 VqD4Rtfc57AFT08bgOwRxW4nL6ZlTDP8QTsNS9GsgiAjiQ0lBnML55M/60JVstmEw47yCUkuGUf
 vwEJhzVCqll3LQgsUWruBpp7vJxgdPqd4P/yszNIdRxhc21D1eDfZWKyj7xBym7DiZZqK2xLocB
 kKeZDk/2/uAreVlAx+gFhnElhMFf9pVSdOLc6DDUxzBzsE5xhUZDEwYs7/0J9eNQdgIQxIPtKYX
 DBLzESnIwZ9MfpWnZ7r/8SbE9omuwCHVWT2V0Xv/PiIZ1n2Pc+C5G8GZIz+WzhkNrUPc9EB6M7B
 00m916epkWlU9XVynGDyEcD4AziVA1J4n/N6OM1llyXlTVtc8S+cfhNHse+JlR9rjxM40y3XoJH
 q9mEFg9JQ1GJ4o5gGudaWHy3l3J+7eqk2JkakjnELA9Qe8Ag3smE3ePDIgD0OnvjOgHgxXTTZOp
 eNVDfWZUnPCX1ahvjR5ngvGUmK0gSI0zVAQrhIIMb8hOD8IdZQgGmrfigZ4pU47ZWdfytbZnfYR
 tmOOxMuaj/zovBw==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
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

On Wed, 24 Jun 2026 13:55:57 +0800, Bin Guo <guobin@linux.alibaba.com> wrote:
> The scanout_bitmask field is uint32_t, but all six bit operations used
> the signed literal `1 << shift`.  When the shift count reaches 31 this
> is undefined behavior (signed integer overflow).  Replace every
> occurrence with `1U << shift` to perform an unsigned shift, which is
> well-defined for all bit positions 0-31.
> 
> No functional change; the result is already stored in a uint32_t, so
> the generated code is identical on most platforms.
> 
> [...]

Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>

-- 
Marc-André Lureau <marcandre.lureau@redhat.com>


