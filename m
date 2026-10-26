Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24327606A31A
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2026 07:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=ZJSSDGff
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xLEps-0003JC-Qa; Mon, 26 Oct 2026 03:09:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1xLEpq-0003I2-8W
 for qemu-devel@nongnu.org; Mon, 26 Oct 2026 03:09:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1xLEpn-0000di-VU
 for qemu-devel@nongnu.org; Mon, 26 Oct 2026 03:09:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1792998571;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=RmkP7uEuwgXf2dwKrI6r9Ue4gPmVqpNg5W8L+XsAOWo=;
 b=ZJSSDGffBVO1JYllMzMMlTBnc9BP53+7t3z92pDdTD34jwpgc8sQJsZeWQpjlu568hf/sb
 5oS7HhLKE0XhsNn5kPuIRZGZVnmBOtbktI6BBeTXtTNIDCgVhf8lSHNr0exgIkkyWKfufZ
 E7ZFrNl5O60k74xRmnYX9F7ifjCnW7s=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-508-PE_3ruM6M_GyKtmZucDaIQ-1; Mon,
 26 Oct 2026 03:08:57 -0400
X-MC-Unique: PE_3ruM6M_GyKtmZucDaIQ-1
X-Mimecast-MFC-AGG-ID: PE_3ruM6M_GyKtmZucDaIQ_1792998536
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E35301800665; Mon, 26 Oct 2026 07:08:55 +0000 (UTC)
Received: from localhost (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 061A818002B7; Mon, 26 Oct 2026 07:08:53 +0000 (UTC)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH 7/8] hw/display/artist: fix off-by-one in VRAM read
 bounds check
From: marcandre.lureau@redhat.com
To: Tristan Madani <tristmd@gmail.com>
Cc: qemu-devel@nongnu.org, qemu-stable@nongnu.org, 
 richard.henderson@linaro.org, hpoussin@reactos.org, arikalo@gmail.com, 
 balaton@eik.bme.hu, qemu-ppc@nongnu.org, deller@gmx.de, pbonzini@redhat.com, 
 fam@euphon.net, mark.cave-ayland@ilande.co.uk, kraxel@redhat.com, 
 berrange@redhat.com
In-Reply-To: <20261025173625.3372689-8-tristan@talencesecurity.com>
References: <20261025173625.3372689-1-tristan@talencesecurity.com>
 <20261025173625.3372689-8-tristan@talencesecurity.com>
Date: Mon, 26 Oct 2026 11:08:30 +0400
Message-Id: <179299851015.907607.1535846194445752941.b4-review@b4>
X-Developer-Signature: v=1; a=openpgp-sha256; l=715;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=YLLfPXxaOd4F19ZnQUYPKSY/++ci5IRYrRjh3MHLcv0=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBq3vxwNKCu6opp5zyu8ZbNbjjlrcf+FbhRN83p3
 1ABv74M1+GJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCat78cAAKCRDa6OEJdZac
 5faSD/44cL4+Dhh0bq/HS9SD/PuSeA9bewjhG5v0fLph+efdv2Qkx5YdYdMJlsrc+1kw3ZjHbKc
 VaPf88AZ0cJgLXeWpd+ZwxnEKzVhEuTU7rQRZ7KitExUixXHZTNk4K4UWUCzODKNJnNnq+perRw
 av7btJSbGaN+Web1tHAGGNPSZWj2pF04riZ7JtcyZf1sghySim2N6qwZBhIk47AfIFNgXGyDF8Y
 2UBuZC4fhTXLhU6Ahwe90Ba5NyYDoVt32tU0QNyDP+DXpHGCyq+lxy3Mjd7Vh51iwes2yYkm57N
 MGcPpo/ya9lgW48J6zy6efT0YaXzNPJfud78gdQpGnTSZ7y5T/bAlsVmVB8O6g/pMb5Wln6RqaT
 lS5ireAh2ccxzWJhZ6PM+qdzmNugHH0Nl8K0/kXpsgjDXiV0ZliMneNBHuAbzMo9BH+W2ijoSFZ
 jCgO+2l27Ts2gFvI53Mz9dRmpvY8+BrVCggorzp6qSOk9fpUrTckSaPvssLXHf+D1IfrfCk7nw3
 gGGUdOZwLjzm+qtp4tU9KvEAALeaC50so1ek1dku/hbfJ7QA6Rd9m/ozViL3ICA7wk0CEo8KhB4
 ZJVGjrTbetuxQoDyw1iCuSBmCq/ChoVuS7A0rC7eM1AOtr7lj+UaWcLHYiHIWvWUIV9iAwvTmtY
 swJ0dMor058sATA==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.339,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Sun, 25 Oct 2026 17:36:24 +0000, Tristan Madani <tristmd@gmail.com> wrote:
> artist_vram_read() uses "offset > buf->size" instead of checking
> that the full uint32_t read fits within the buffer. This allows a
> 4-byte read at exactly buf->data + buf->size, entirely past the
> heap allocation. All write paths in the same file correctly use
> ">=" (artist_rop8, block_move, font_write16).
> 
> A guest can trigger this via MMIO read addresses that produce
> offset == buf->size. The read value is returned to the guest,
> leaking 4 bytes of adjacent host heap data.
> 
> [...]

Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>

-- 
Marc-André Lureau <marcandre.lureau@redhat.com>


