Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7236FF885A
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2026 10:30:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wJqYD-000304-Fa; Mon, 04 May 2026 06:29:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wJqY9-0002zc-Ne
 for qemu-devel@nongnu.org; Mon, 04 May 2026 06:29:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wJqY6-0002pd-Uf
 for qemu-devel@nongnu.org; Mon, 04 May 2026 06:29:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1777890552;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HASvZahSUPGyOijMW9fSrqEPrE4bySRrIIujazNKyhA=;
 b=Hqm1R9tphEzAIY1l9gbdhfdJe4I6AbBAVK9nqaw7yu54aEtHpy2Au+j/C8dRUPooFHjsPP
 qEgHp9PnUYCvJiMF6B1HxK/Xf5mFBEQA6JhQJvpbYy5k6LMw9JXuJYRys5h/HtXX9NpFfr
 t4fA/fQ9c5LJRaDTTW74ADzU+L7+OJs=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-513-KsFbb6eoN4uyBU4ZFKZSzQ-1; Mon,
 04 May 2026 06:29:10 -0400
X-MC-Unique: KsFbb6eoN4uyBU4ZFKZSzQ-1
X-Mimecast-MFC-AGG-ID: KsFbb6eoN4uyBU4ZFKZSzQ_1777890548
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 4B01B1956068; Mon,  4 May 2026 10:29:08 +0000 (UTC)
Received: from localhost (unknown [10.44.24.4])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 72F1B1800480; Mon,  4 May 2026 10:29:06 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH 38/41] target/riscv: fix general_user_opts hash table leak
From: marcandre.lureau@redhat.com
To: Alistair Francis <alistair23@gmail.com>
Cc: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 qemu-devel@nongnu.org, armbru@redhat.com, 
 Palmer Dabbelt <palmer@dabbelt.com>, 
 Alistair Francis <alistair.francis@wdc.com>, 
 Weiwei Li <liwei1518@gmail.com>, 
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>, 
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, 
 Chao Liu <chao.liu.zevorn@gmail.com>, qemu-riscv@nongnu.org
In-Reply-To: <CAKmqyKPQWSEtpgMSoMuBwa0L_QrjMoKq_mCoCXWSa-z5KaAEuw@mail.gmail.com>
References: <20260427-qom-tests-v1-0-c413f3605311@redhat.com>
 <20260427-qom-tests-v1-38-c413f3605311@redhat.com>
 <CAKmqyKPQWSEtpgMSoMuBwa0L_QrjMoKq_mCoCXWSa-z5KaAEuw@mail.gmail.com>
Date: Mon, 04 May 2026 14:29:01 +0400
Message-Id: <177789054154.3356859.10831690879720759239.b4-reply@b4>
X-Developer-Signature: v=1; a=openpgp-sha256; l=639;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=huozlfuVBXlkSJypCwGwvctq29OcCMMjmxHIfdZKeDw=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBp+HTt+BZpH3cVt+P+hzo2sCLzwZCzqfnMln1dx
 Ymifkhqx0WJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCafh07QAKCRDa6OEJdZac
 5c0KD/9iib4pULxtDeZXESUyAOZLfxDuOANzHbjR96Jp1/uVwH5D1bS+HbX40CdwPyvsDQsHl0K
 ksQviGS7Yt+4Ppd1DKMmYIN7HYhBBBalGb+HnkAt33yCxiRReGQZkHHbESn+3tiJDlPQdwxRf6f
 MzGh3l7aRfqYdbsXBvN0CV23gcPpPuTPSAYSirwxjlnBYXvKBXdytazsrvFbTfByx2bkx+1rkj0
 AXITU+9hxjTL0knn/5uPuhRkv4wCMRC5jcBD6/fi9Gd2LRK9l05ZkbG5EZkxT20bKYE2YkZEfGp
 G14qAD7EYBGN65jkpnq5+avqWg6equq8nxMkOW/PJvppyqaJDA6gEO9XtdWkSdknVm4GzCE2VQc
 evlr0pUJQdxw5r0jzjrhNkV1eC+jvURajz509PTj10ryLPQO34IpR5yN06C3EPzwCXWgnjds6Db
 2mMcxhx/lWwjlJWs50sjgXhUkaosSaHTfA8klqbnlmSTFRSXv403EVt3WqTTHSH/ouQ0yjNmTCU
 nB9FtWAR9r422Y0AkXK+1Knr5LGHRWvtG/j2fjGHUc0X5wLQPunOIrfH8dL8X+6h6ADD/gMk3rK
 kHJ8NMPWo6o1YQfb04ExhwhOlPjiynaUDL/D/+Gnmsep3fj6L6kVdkhliyBIW4mR3MteH0Xi93J
 Vb8n9SXHSnSwhvg==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 8
X-Spam_score: 0.8
X-Spam_bar: /
X-Spam_report: (0.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.444,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Hi

On 2026-05-01 11:53:40+10:00, Alistair Francis wrote:
> On Tue, Apr 28, 2026 at 5:50 AM Marc-André Lureau
> <marcandre.lureau@redhat.com> wrote:
> 
> > The global general_user_opts hash table is recreated on every
> > riscv_cpu_init() call, leaking the previous one. Clear any existing
> > table before creating a new one, and destroy it on CPU finalization.
> 
> @Daniel Henrique Barboza I'm pretty sure there should only ever be one
> instance of general_user_opts and that's the bug
>

Actually, it looks like it should be per-instance. And we could use a
hash set rather than a hashmap. I will update the patch.


