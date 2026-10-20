Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CFFB606A319
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Oct 2026 06:35:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=V6k8JBLX
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xJ3QV-000399-BH; Tue, 20 Oct 2026 02:34:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1xJ3QK-00038H-CN
 for qemu-devel@nongnu.org; Tue, 20 Oct 2026 02:34:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1xJ3QI-0007xo-PV
 for qemu-devel@nongnu.org; Tue, 20 Oct 2026 02:34:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1792478050;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=UPiGL4a+3jcUcwjR49W2SjtjbghEeSf1LeBhIDfsWOM=;
 b=V6k8JBLXN6rDUipieuJzboHq7l3G8e06wVI42iUENktVqaA1k7pR23eNeGiUSuDso5XoGe
 oW6qihGHC7axMqopo7jfuiymzxG95kYNXfvptBS75KQckGmmAZ7o+Le9VD51fBhFx39+Bx
 81hpniXtYVst6zSLiC8aoG0ddf3RrmE=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-688-4IB6Ft4_NzyyHL1HAOLaeg-1; Tue,
 20 Oct 2026 06:34:06 +0000
X-MC-Unique: 4IB6Ft4_NzyyHL1HAOLaeg-1
X-Mimecast-MFC-AGG-ID: 4IB6Ft4_NzyyHL1HAOLaeg_1792478045
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 7F9CD18005A2; Tue, 20 Oct 2026 06:34:05 +0000 (UTC)
Received: from localhost (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 4F0891800347; Tue, 20 Oct 2026 06:34:03 +0000 (UTC)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v6 06/65] qapi/introspect: Tweak integer type masking
From: marcandre.lureau@redhat.com
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, marcandre.lureau@redhat.com, pbonzini@redhat.com, 
 berrange@redhat.com, michael.roth@amd.com, 
 pierrick.bouvier@oss.qualcomm.com, philmd@oss.qualcomm.com, 
 kkostiuk@redhat.com, alistair.francis@wdc.com, amachhiw@linux.ibm.com
In-Reply-To: <20261019141929.1594337-7-armbru@redhat.com>
References: <20261019141929.1594337-1-armbru@redhat.com>
 <20261019141929.1594337-7-armbru@redhat.com>
Date: Tue, 20 Oct 2026 10:33:32 +0400
Message-Id: <179247801297.2782576.12407403317067460024.b4-review@b4>
X-Developer-Signature: v=1; a=openpgp-sha256; l=367;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=hP3/zJxmfeA/zRqntflMzwGhLdGW2y+jZ/Tzpzvyh8M=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBq1wtC5x48bxHCw9mjJJr+otLibyw9AnXiJNOpM
 YXbmKMmNrOJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCatcLQgAKCRDa6OEJdZac
 5S0sD/9fa99lMJCTe9FVPrlAQRfSJ3K2fWldWELee6+r4fQa3PXS4vjf3kNNduBOOkq1Rmt9wS7
 3FOts8Fe7SQEt6NALDyrPvNhXqhlmmwCuPVMhbpBrAZR3EEwgZwBhfUUhDNqgSsH2yN3RIuEG41
 L2u+Pv32cDY4nZLLByT9oNMXHkIIaxvolcuaNT5CTejo+Vq1IecJXaLu1xdl276K0kwyEobAtdM
 wItOsOvyIS0qyLE5/Hvzn4Od8CQCMdmG9V2mBIuMmEfyEtuNrFK9J8OWNrzjABj7cqgx3JoSYex
 bxW4N0jR98XlS9rpUF7GgQVKzaEjW6vkfsfBmihwqAAPd9JSlYFMeu0d/3/nTsYTgx5aPs+69LQ
 423vKLY8J6JUluaNvCPEA4sGQHDMJHMGUIuJlMsIbb7PjLaVU7p90G7lr0XPYj4bpOU6vBad0jW
 CRuG7QQu8V2qYyX5sPh4hra0nhH41WJiHz8Ij20I1urD/mCTyMH/WphMEqEoV0krMTo0NXwi7Zl
 xHKzbJAR1qeRp/CR7fgFdCeN3EFpXj0uq+SSoNh2ljSJcybpCOnz7Gib77RYFwifQbjy/26OUlD
 s6RY/teUC+4BNimjrEm9Mi9TNlkzO/mbICIzUNTrTvAz28sGzqo5Rqc4ae2Ha8jPmHI6BoSI0ng
 o6ZJ5gNm0GEDs6Q==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.329,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Mon, 19 Oct 2026 16:18:30 +0200, Markus Armbruster <armbru@redhat.com> wrote:
> Since introspection maps all integer types to 'int', we need to skip
> all but one of them.  Instead of filtering by hardcoded name, filter
> out duplicates.

Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>

-- 
Marc-André Lureau <marcandre.lureau@redhat.com>


