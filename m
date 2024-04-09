Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A1EBC67861
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Apr 2024 14:19:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ruCIm-0000z2-QL; Tue, 09 Apr 2024 10:18:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1ruCIi-0000up-N4
 for qemu-devel@nongnu.org; Tue, 09 Apr 2024 10:18:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1ruCIh-0007Sh-54
 for qemu-devel@nongnu.org; Tue, 09 Apr 2024 10:18:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1712672293;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=K8bHWtXaljA2G7E0ZnS4Aj4dYYMdmQALrl61OB/mrUs=;
 b=YL1rVNgvM/WZENnv4rkNOeOkjnyAAx6Vqgrg9XRj0PZv+Ic+p1Lky4sIEBH8ij+x7ExNmu
 tgYwSgPI/cJLeRicHgfKuX12DUU72tilcAzWrhegykMRlnfz5+wwSmXLHbD/Q2SrGazPvw
 DVHpnR5pcmq2J9Ri9P04PPOQ74425pE=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-327-f6m7qKURNq6-fYL4dnFOiw-1; Tue, 09 Apr 2024 10:18:10 -0400
X-MC-Unique: f6m7qKURNq6-fYL4dnFOiw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
 [10.11.54.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 012DD1049B86;
 Tue,  9 Apr 2024 14:18:10 +0000 (UTC)
Received: from redhat.com (unknown [10.39.192.74])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 17B2D2166B36;
 Tue,  9 Apr 2024 14:18:08 +0000 (UTC)
Date: Tue, 9 Apr 2024 16:18:03 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Qiang Liu <cyruscyliu@gmail.com>,
 qemu-block@nongnu.org, Alexander Bulekov <alxndr@bu.edu>,
 Hanna Reitz <hreitz@redhat.com>
Subject: Re: [PATCH-for-9.0 v2 0/3] hw/block/nand: Fix out-of-bound access in
 NAND block buffer
Message-ID: <ZhVOGxCG9zfludIs@redhat.com>
References: <20240409135944.24997-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240409135944.24997-1-philmd@linaro.org>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.6
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -37
X-Spam_score: -3.8
X-Spam_bar: ---
X-Spam_report: (-3.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.701,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Am 09.04.2024 um 15:59 hat Philippe Mathieu-Daudé geschrieben:
> Fix for https://gitlab.com/qemu-project/qemu/-/issues/1446
> 
> Since v1:
> - Addressed Kevin trivial suggestions (unsigned offset)

You already kept the Reviewed-by tags, but looks good to me.

Kevin


