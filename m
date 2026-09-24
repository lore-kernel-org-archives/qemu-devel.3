Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C541DC98314
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Sep 2026 07:42:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x9e5Y-0000Zu-SD; Thu, 24 Sep 2026 03:41:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1x9e5H-0000VC-Sv
 for qemu-devel@nongnu.org; Thu, 24 Sep 2026 03:41:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1x9e5G-0001Xj-1B
 for qemu-devel@nongnu.org; Thu, 24 Sep 2026 03:41:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1790235693;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1rsvGfy27mhSgi5t+9dyfupFWg1/kWRZab/i+dRGaPU=;
 b=V7cx0dJYN6XT4SnB7SsfuR3xl1l9RinoW217IIwrfD0p+VC0Vx+acgEjg5yFZeAVO+k9Er
 QJUVFoueg6lVC1biDUN8rs8Li1BfKFglB2LuG3g1UwcdWBANA3fRgGw3ZsmXjBPjGYQM0b
 h7+C4cUA6Zhy74gnw2eQmOSu4zyuTVg=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-189-hqx7SQ0CPTuc0BNGdxxFIA-1; Thu,
 24 Sep 2026 03:41:31 -0400
X-MC-Unique: hqx7SQ0CPTuc0BNGdxxFIA-1
X-Mimecast-MFC-AGG-ID: hqx7SQ0CPTuc0BNGdxxFIA_1790235691
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E4C2F1954AC2; Thu, 24 Sep 2026 07:41:30 +0000 (UTC)
Received: from localhost (headnet03.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.114])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 25E4618005B5; Thu, 24 Sep 2026 07:41:29 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH 07/10] hw/tpm: crb: Avoid potential integer underflow
From: marcandre.lureau@redhat.com
To: Stefan Berger <stefanb@linux.ibm.com>
Cc: qemu-devel@nongnu.org, armenon@redhat.com, marcandre.lureau@gmail.com
In-Reply-To: <20260924012527.858527-8-stefanb@linux.ibm.com>
References: <20260924012527.858527-1-stefanb@linux.ibm.com>
 <20260924012527.858527-8-stefanb@linux.ibm.com>
Date: Thu, 24 Sep 2026 11:41:04 +0400
Message-Id: <179023566487.1794827.5978942868097875478.b4-review@b4>
X-Developer-Signature: v=1; a=openpgp-sha256; l=740;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=yG4tIXjkcbbklzqScLQKfoPs6/HzG8v3WqykfqiPg5M=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqtNQTaaOs/AsWtM/mKseP/XWQkg/6mbVQ0QiEe
 8tiYNS1jJiJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCarTUEwAKCRDa6OEJdZac
 5Zi6D/9QdJbh3uCHhkVJ6ufk75b3pQu6hHbLslVUIaCxQ0FAY4TTc/YyLbVipeDgbXF0a0nU1d2
 qCJ3Uh982eVMoGakK6fOwO20ff8ZYxl37t5l4Dg/9kJMgSl/H9FgRLNd8WVzgiT4ApLK43VGuUe
 OzN/YYB3qeacT5GwBtb5xNYN+utvWSGqHSlJCf4v/a573qHk6FDOUJ5WKQ7HVsn1fsLPn8jQ8yL
 0PrYW43z93j5FmLztETFMZMGrEFK0RYWUdk13crkicXXdFB6tkWcFHhHggTVn5HpuT2A+1CIHLs
 1DJl5ARqz2jYonp2FmuyWRfGEaeHUYJGFKYZyy3AgHviSytskM8klz/UOekXWUl0brFm1/H3li4
 2onmoTgPVe/9zecoGzPJsNY/wk6cQS2H9MXaMddEnC4CxAzBCDi3e7sE2gst3YNN3rsjPWUpfyQ
 7u+cMIB0JOpaHep0NFqkZttgJ1ffu7QfDw59zgtP4HZJDFAxiQyUckuRbfGM2GHePh9yriQ38W1
 AgxD7lvI5ZfZ+ID99+YYK+oDpeKpzR9Dx3eq6wSWgUvcj7g3HL+uBiV9JOLUm2rCTu7QRrbiZM1
 F8clxGCCUKudwTAs7CRfSJUuszODmPpQZb0ykmi5WRpTC++YOMjjU6PJcPZs6a4kJDL/8+OpuU/
 LANcbn3ckt+U6kg==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, RCVD_IN_SBL_CSS=3.335,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On Wed, 23 Sep 2026 21:25:24 -0400, Stefan Berger <stefanb@linux.ibm.com> wrote:
> Avoid a potential integer underflow in tpm_crb_fill_command_response
> that could occur if s->response_offset > s->response_buffer->len and
> the function's call sites were to change.
> 
> tpm_crb_fill_command_response currently has 3 callers that either test
> that 's->response_offset < s->response_buffer->len' is true or ensure that
> s->response_offset = 0 and s->response_buffer->len >= 0. Therefore, the
> integer underflow cannot currently occur. In the worst case the subtraction
> would lead to a '0'.
> 
> [...]

Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>

-- 
Marc-André Lureau <marcandre.lureau@redhat.com>


