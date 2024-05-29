Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6ECA6C25B75
	for <qemu-devel@archiver.kernel.org>; Wed, 29 May 2024 16:51:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sCMVi-00017X-QN; Wed, 29 May 2024 12:50:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1sCMVg-00016U-UU
 for qemu-devel@nongnu.org; Wed, 29 May 2024 12:50:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1sCMVf-0002nO-Iv
 for qemu-devel@nongnu.org; Wed, 29 May 2024 12:50:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1717001441;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=DJohKB9OcUzF/8cf7GFlecCUKEIWZd2b0SD0qyzqTFY=;
 b=goMGOLKLfvt45Nx7F9aV74Ac3zqM0soaX6gSPzBh5rebtsS5Hy0pfcsS1tyus15YGMIPYo
 zpFyZcwBdCeITl8Snw2RE8OtjbdOc7bCIT9ixt+wIkn3u2neCCVCBZqZ8JZpKnTE9y4GVT
 4OmkurL/4nheKvmgiAadeVZKuOGSLMk=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-587-p7R9CcFgPXSf1whdExDOwQ-1; Wed,
 29 May 2024 12:50:37 -0400
X-MC-Unique: p7R9CcFgPXSf1whdExDOwQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
 [10.11.54.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id BFAB629AA384;
 Wed, 29 May 2024 16:50:36 +0000 (UTC)
Received: from redhat.com (unknown [10.39.194.254])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id F05792026D68;
 Wed, 29 May 2024 16:50:35 +0000 (UTC)
Date: Wed, 29 May 2024 18:50:34 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-devel@nongnu.org, Hanna Reitz <hreitz@redhat.com>,
 qemu-block@nongnu.org,
 Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>
Subject: Re: [PATCH 0/2] block/crypto: do not require number of threads upfront
Message-ID: <Zldc2nY8pMciuvmB@redhat.com>
References: <20240527155851.892885-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240527155851.892885-1-stefanha@redhat.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.036,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

Am 27.05.2024 um 17:58 hat Stefan Hajnoczi geschrieben:
> The block layer does not know how many threads will perform I/O. It is possible
> to exceed the number of threads that is given to qcrypto_block_open() and this
> can trigger an assertion failure in qcrypto_block_pop_cipher().
> 
> This patch series removes the n_threads argument and instead handles an
> arbitrary number of threads.
> ---
> Is it secure to store the key in QCryptoBlock? In this series I assumed the
> answer is yes since the QCryptoBlock's cipher state is equally sensitive, but
> I'm not familiar with this code or a crypto expert.

I would assume the same, but I'm not merging this yet because I think
you said you'd like to have input from danpb?

Reviewed-by: Kevin Wolf <kwolf@redhat.com>


