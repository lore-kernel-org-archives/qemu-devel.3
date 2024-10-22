Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02808CDD0F8
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Oct 2024 20:47:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t3LmF-0005jE-2O; Tue, 22 Oct 2024 16:46:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1t3LmD-0005iy-0y
 for qemu-devel@nongnu.org; Tue, 22 Oct 2024 16:46:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1t3Lm9-0001Xl-QK
 for qemu-devel@nongnu.org; Tue, 22 Oct 2024 16:46:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1729630003;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=TAxjVbU/c4Br/yv7+EGe+7tGFsz2H0De4/C6uMgbsYg=;
 b=bOYjLAsuiDViNLPVheUaw9tx460aNpB/IWcrEwUdUAtgRd8GhxlFTEs5NzLRRJBLEeSOaZ
 J6m9oG/eEzoV0ssV0fiQX6m9iUfN73iB4cNNEktRawc616BV57Oj2BGag3W6wU6NV4eNmO
 MPkIstgfonWaIDsY9kbyydtccPdf3BI=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-614-ggDiJWutNGeRIRGEw0q0gg-1; Tue,
 22 Oct 2024 16:46:40 -0400
X-MC-Unique: ggDiJWutNGeRIRGEw0q0gg-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E23F919560A3; Tue, 22 Oct 2024 20:46:38 +0000 (UTC)
Received: from redhat.com (unknown [10.39.194.70])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 8C47819560B2; Tue, 22 Oct 2024 20:46:36 +0000 (UTC)
Date: Tue, 22 Oct 2024 22:46:34 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Junjie Mao <junjie.mao@hotmail.com>
Subject: Re: [PATCH v2 00/13] rust: miscellaneous cleanups + QOM integration
 tests
Message-ID: <ZxgPKjakya_FwjLu@redhat.com>
References: <20241021163538.136941-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241021163538.136941-1-pbonzini@redhat.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.519,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

Am 21.10.2024 um 18:35 hat Paolo Bonzini geschrieben:
> This series integrates some of the observations from the MSRV patches at
> https://lore.kernel.org/qemu-devel/20241015131735.518771-1-pbonzini@redhat.com/.
> 
> The main changes here are two: first, build an integration test that
> actually tries to create a QOM object that is defined by Rust code;
> second, make the properties array immutable so that declare_properties!
> is enforced to use only const-friendly constructs.  These are patches
> 6-11; the others consist of small cleanups.
> 
> Hidden in here is actually a C patch (#10) which makes the
> bindgen-generated prototypes use "*const" instead of "*mut".
> 
> Tested with Rust nightly and (together with more patches from the
> RFC), with Rust 1.63.0.
> 
> Unlike the MSRV patches, this should be ready for inclusion; the
> changes should be mostly uncontroversial.

I'm not convinced that Zeroable has sufficient justification when all it
does is saving us a few lines of code at the expense of making things
more implicit. But it's used correctly as far as I can tell, so:

Reviewed-by: Kevin Wolf <kwolf@redhat.com>


