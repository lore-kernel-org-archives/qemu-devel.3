Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A9EBCA9EC5
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Oct 2026 21:54:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xGNxH-0000W5-4G; Mon, 12 Oct 2026 17:53:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1xGNxG-0000Vv-5L
 for qemu-devel@nongnu.org; Mon, 12 Oct 2026 17:53:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1xGNxE-0006R8-RR
 for qemu-devel@nongnu.org; Mon, 12 Oct 2026 17:53:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1791841988;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rLrZPxGvVn6bT6Rqj5TlcNXGmcoHhShQAmqHAjyBr8k=;
 b=APVmIyB6EtkG9YurOVdjOdaWScoVk+KGtNSiiUSsiJ6255tp2rNzuXqnIobBH0peKksQxw
 rMm8MMGxtzlJXWa9g8qTJFg2LuypsEI268+D/WBy+aV541jrSU3ECs8jjZyh1ilTzBQZ03
 SiFhCT2FV/zRXJwOlFFXLcW55+PQnZ8=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-694-nNsT3KnZNqarF_RmQk4i5g-1; Mon,
 12 Oct 2026 21:53:02 +0000
X-MC-Unique: nNsT3KnZNqarF_RmQk4i5g-1
X-Mimecast-MFC-AGG-ID: nNsT3KnZNqarF_RmQk4i5g_1791841980
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 4E2C11800679; Mon, 12 Oct 2026 21:52:59 +0000 (UTC)
Received: from localhost (headnet03.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.114])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 6AA7430000E7; Mon, 12 Oct 2026 21:52:58 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 14/16] tests/functional: split s390x tuxrun into tcg
 and kvm run
From: marcandre.lureau@redhat.com
To: =?utf-8?q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>, 
 Zhao Liu <zhao1.liu@intel.com>, Kyle Evans <kevans@freebsd.org>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Brian Cain <brian.cain@oss.qualcomm.com>, 
 Richard Henderson <richard.henderson@linaro.org>, 
 Brad Smith <brad@comstyle.com>, Ani Sinha <anisinha@redhat.com>, 
 Christian Borntraeger <borntraeger@linux.ibm.com>, 
 Thomas Huth <th.huth+qemu@posteo.eu>, Keith Busch <kbusch@kernel.org>, 
 Matthew Rosato <mjrosato@linux.ibm.com>, Cornelia Huck <cohuck@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, Halil Pasic <pasic@linux.ibm.com>, 
 John Snow <jsnow@redhat.com>, Eric Farman <farman@linux.ibm.com>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 Anders Roxell <anders.roxell@linaro.org>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>, Warner Losh <imp@bsdimp.com>, 
 qemu-arm@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, 
 Yoshinori Sato <yoshinori.sato@nifty.com>, Peter Xu <peterx@redhat.com>, 
 Klaus Jensen <its@irrelevant.dk>, Song Gao <gaosong@loongson.cn>, 
 qemu-s390x@nongnu.org, Laurent Vivier <laurent@vivier.eu>, 
 Ilya Leoshkevich <iii@linux.ibm.com>
In-Reply-To: <20261012170330.1144446-15-alex.bennee@linaro.org>
References: <20261012170330.1144446-1-alex.bennee@linaro.org>
 <20261012170330.1144446-15-alex.bennee@linaro.org>
Date: Tue, 13 Oct 2026 01:52:29 +0400
Message-Id: <179184194936.2190936.13610950904285285847.b4-review@b4>
X-Developer-Signature: v=1; a=openpgp-sha256; l=385;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=yCnIm+Ne+Unx6YSsDBKwjbgpTsTGflVtWw20mZCVwok=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqzVaf88VvD7YBXZ/JDIwAgpECy64Z/yQB+jLiq
 /+BJUpdNZ6JAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCas1WnwAKCRDa6OEJdZac
 5TTAD/9Q+sYtQzCmKQBrqiA8hg5e+qck5yXlSrEW69uSxVLLICmlfpf8mhfnecfe8R1JVsG/r2E
 Xs4aCRLzmoNpAj5P8/dqUTmd7/hJSoX+EhCgGhW3er3/ZDMWRQlf9aKVH+FxLdKYcRSc9IdANO/
 ZrzpFhSG2qFyGY6xZKO6ZCmf4z903Nb+BPB2gL3h6RHVM9QKWiZUURcXhjS9FYVXZvSYfQnjIy/
 Sz7mauL/RwSgX1S0Q/p7NEoj+CK+qshaLBSkT8DXfIQ4nPpnQeQeEGb7Z55wGDdeAFPgTw1kOa3
 mPlVW1fUM9dpC3qPVCL2xQjvS3/tSdxf8791/sd+nACEW0nURL0AJukJdov2mpQOuM6N2bw9YUE
 7hXHkFzyS/VzARHX8SwqW1maqdHg53LRv5Lo3+AK21uysU57M9ngRDL2zZB3mLCq1iwdgMZB2t4
 OYWmbWHB4aQK3cVsDQVs7hMTF2xFUmKT8rILry2BXjz2911Yr0vEQ8pg4aAwpoPStH4qFj4G/PB
 o7G6WLORjKFqNbSLlPIazZzL3xqHzFcnxCLuOz7sS2I+JDJy/XTo0ifDyPUIhNa5pdHYC42Yj8O
 G2qFVLWABKAAIpes06QSgHLnZ54oQBfca8RnvJbSvN8oEoRi+62xSs9aDYx8bQHBM28K3ir2jlQ
 Okf7yOefqkPekow==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.24,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Mon, 12 Oct 2026 18:03:28 +0100, Alex Bennée <alex.bennee@linaro.org> wrote:
> Add an explicit "kvm" run to the tuxrun tests. Although running on an
> s390x host would probably have defaulted to "kvm" anyway we want to
> exercise specific features later.

Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>

-- 
Marc-André Lureau <marcandre.lureau@redhat.com>


