Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97B52606A31B
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2026 07:10:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=bC+4qCYo
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xLEpN-000352-1L; Mon, 26 Oct 2026 03:09:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1xLEpB-00031y-SA
 for qemu-devel@nongnu.org; Mon, 26 Oct 2026 03:08:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1xLEpA-0000ah-8h
 for qemu-devel@nongnu.org; Mon, 26 Oct 2026 03:08:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1792998531;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+dZWX2bIxDNSf/cFI0LlzpDumsKkD5JizKmt/rLqzsE=;
 b=bC+4qCYoUzNWVQGTYlw+SIGYKyKu5VvWVrXg4LGZgploZIjr0i0FLS6XoPZ4AXFylgQwX+
 4dm4ghsQq8VwJJ3r5FWxh452T0r39M8mmWSAay8I6jQAu0FJMzYD3aD72A5cTLGbfcxxy9
 YKyxKm75ESQsPuBNBmUYfJ5EnAjeLdg=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-329-UowSK8hPOI6qBB8AgDWJQg-1; Mon,
 26 Oct 2026 03:08:45 -0400
X-MC-Unique: UowSK8hPOI6qBB8AgDWJQg-1
X-Mimecast-MFC-AGG-ID: UowSK8hPOI6qBB8AgDWJQg_1792998521
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id BE0111800623; Mon, 26 Oct 2026 07:08:40 +0000 (UTC)
Received: from localhost (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 109C91956086; Mon, 26 Oct 2026 07:08:38 +0000 (UTC)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH 2/8] hw/display/ati: reject 2D blit when width exceeds
 stride
From: marcandre.lureau@redhat.com
To: Tristan Madani <tristmd@gmail.com>
Cc: qemu-devel@nongnu.org, qemu-stable@nongnu.org, 
 richard.henderson@linaro.org, hpoussin@reactos.org, arikalo@gmail.com, 
 balaton@eik.bme.hu, qemu-ppc@nongnu.org, deller@gmx.de, pbonzini@redhat.com, 
 fam@euphon.net, mark.cave-ayland@ilande.co.uk, kraxel@redhat.com, 
 berrange@redhat.com
In-Reply-To: <20261025173625.3372689-3-tristan@talencesecurity.com>
References: <20261025173625.3372689-1-tristan@talencesecurity.com>
 <20261025173625.3372689-3-tristan@talencesecurity.com>
Date: Mon, 26 Oct 2026 11:08:30 +0400
Message-Id: <179299851011.907607.16070959329380694539.b4-review@b4>
X-Developer-Signature: v=1; a=openpgp-sha256; l=578;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=sT0QcJmnE6vK9rlJRLjApspDZuUPZLwZyr6JqKTEvZA=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBq3vxvvWPtzkja1UpqE89V3hVlrahwLyD3orRhL
 zlEniX+JmSJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCat78bwAKCRDa6OEJdZac
 5dENEACY28ff8PlZYbqvZbh2q7oAYkmygrKJUCLF+WccKJy+tlnOKCT5Rs8QCLNqkNuREpLgh1M
 Hd8+6XlFOanzFMvVKpAqNcBREJqNjmzcy2THuWU46SopgRr31gBIbLySfleah5n4Se6C22tWVeJ
 IDDU5I+JD2RlQN3nWb0BuRANkLoVnqgqwQw3HmPEO2ot++f3tRaJDreMc29U5ooT7ZF0MIHBCEI
 KgJGAWYJBV4uWy66xrjo+DdDBbPqnRaGAsvuEQtbc8f5dm9zC/XrJ/9N4MvwfTq+4/+oRRHB+Hf
 cwtqbp7BNdt6QDknHnWPImQR3ByY9KYHEFGOWriq74t7ogXmBJKqSEnL6cF7SZIwF1qKQL9pKf2
 3LX05d1wFTu+2oyWArKSa6KG9IDrLxcp90XRUBTexwWnr7CbXdskasixPHqnJCVsVu+5JSVuxyb
 TZSPslSLvR+zQQKoedw15UZKRVqspc2KwTmSoGy5LdVQXEx76BhuaLu+qAzereA1lvIQQTRJeAO
 X1AHaGn+/LxcfJlvGq3qTxmxhr89EfxrTQaFcRQGTx4wHPwLUdw2BquKbncZm6xxeEsazHyXEdy
 6UZc3GQxO4ZLip/RW9CByTpjzwU2QYmMTMVmke+h7H2ozBclS92XD3M41RlyMtcYdIWtR1NELg4
 +f5lK78YBdq0bFg==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.339,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Sun, 25 Oct 2026 17:36:19 +0000, Tristan Madani <tristmd@gmail.com> wrote:
> The VRAM bounds check in ati_2d_do_blt() validates the destination
> area using (dst.y + dst.height) * dst_stride, but does not validate
> that dst.width * bypp <= dst_stride. When a guest sets the blit
> width wider than the pitch, each row's memmove/fill extends past the
> stride-computed bound, writing up to 64 KB past the VRAM allocation
> boundary.
> 
> [...]

Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>

-- 
Marc-André Lureau <marcandre.lureau@redhat.com>


