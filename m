Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37321E9A74F
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Mar 2026 09:45:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w4yJf-0008CR-Ld; Tue, 24 Mar 2026 05:44:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1w4yJb-0008Ar-Pw
 for qemu-devel@nongnu.org; Tue, 24 Mar 2026 05:44:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1w4yJT-0007NC-1e
 for qemu-devel@nongnu.org; Tue, 24 Mar 2026 05:44:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1774345475;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=gNFJHizdAZGv/2MKKFAxoSlRdE0PAxnIbk2FxsxC54s=;
 b=RjMIV8w+SnjGNrubJGYJQ+qepcqzOWWV2X65zBV8dspTzc163IFQftFhBdZUxV4h6Dw66J
 8hEzwNChSSLdn/gvFVIOsbCmFLRpIpwuNa/+kDm1IKhJ0YiftfG693rtREVgn96uazBKuO
 SyY2VN+8+jyofwHIGjGO9r4mem/BoEA=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-5-c8p8yr9ANumE_MHczve6GA-1; Tue,
 24 Mar 2026 05:44:33 -0400
X-MC-Unique: c8p8yr9ANumE_MHczve6GA-1
X-Mimecast-MFC-AGG-ID: c8p8yr9ANumE_MHczve6GA_1774345472
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id CCBB119560A1; Tue, 24 Mar 2026 09:44:31 +0000 (UTC)
Received: from redhat.com (unknown [10.44.33.246])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 0484D300019F; Tue, 24 Mar 2026 09:44:29 +0000 (UTC)
Date: Tue, 24 Mar 2026 10:44:27 +0100
From: Kevin Wolf <kwolf@redhat.com>
To: zhaoguohan_salmon@163.com
Cc: Hanna Reitz <hreitz@redhat.com>, qemu-block@nongnu.org,
 qemu-devel@nongnu.org, GuoHan Zhao <zhaoguohan@kylinos.cn>
Subject: Re: [PATCH] block/curl: free s->password in cleanup paths
Message-ID: <acJc-zg_QkKG2ltM@redhat.com>
References: <20260320063016.262954-1-zhaoguohan_salmon@163.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260320063016.262954-1-zhaoguohan_salmon@163.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

Am 20.03.2026 um 07:30 hat zhaoguohan_salmon@163.com geschrieben:
> From: GuoHan Zhao <zhaoguohan@kylinos.cn>
> 
> When password-secret is used, curl_open() resolves it with
> qcrypto_secret_lookup_as_utf8() and stores the returned buffer in
> s->password.
> 
> Unlike s->proxypassword, s->password is not freed either in the open
> failure path or in curl_close(), so the resolved secret leaks once it
> has been allocated.
> 
> Free s->password in both cleanup paths.
> 
> Signed-off-by: GuoHan Zhao <zhaoguohan@kylinos.cn>

Fixes: 1bff96064290 ('curl: add support for HTTP authentication parameters')

Thanks, applied to the block branch.

Kevin


