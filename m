Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 280EDCA5FB3
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Oct 2026 09:44:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xCDJf-0005yL-2v; Thu, 01 Oct 2026 05:43:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1xCDJd-0005xo-5M
 for qemu-devel@nongnu.org; Thu, 01 Oct 2026 05:43:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1xCDJb-0003Mm-Ou
 for qemu-devel@nongnu.org; Thu, 01 Oct 2026 05:43:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1790847779;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0kY8+eAnAJul5bRxRRQA3yutAESSCgTvsGmApG+Q8v4=;
 b=X7mp80KRxTdatUrll3rVIPH7RVwoYdi69EKSejtwVXOf3+c7ezXHMCeQqniuIk4LJxgW8Z
 N6ViUA2Y5t62wa9XVbjXA+Vk5c5jQSzCiQjm/rrIa+Q6KEr6r0vikmbaHL1lj1UuDy9pW+
 FOVt5JLRG1RhFPOnOtQM3gig9mj5+JA=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-336-pwQqBF9EPC69ltCSuBXjYA-1; Thu,
 01 Oct 2026 05:42:58 -0400
X-MC-Unique: pwQqBF9EPC69ltCSuBXjYA-1
X-Mimecast-MFC-AGG-ID: pwQqBF9EPC69ltCSuBXjYA_1790847777
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id EEEE918005AB; Thu,  1 Oct 2026 09:42:56 +0000 (UTC)
Received: from localhost (headnet05.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.117])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 301051956045; Thu,  1 Oct 2026 09:42:55 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 05/11] qemu-option: Add qemu_opts_parse_list
From: marcandre.lureau@redhat.com
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>, 
 =?utf-8?q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>
In-Reply-To: <20260930221105.2262063-6-farosas@suse.de>
References: <20260930221105.2262063-1-farosas@suse.de>
 <20260930221105.2262063-6-farosas@suse.de>
Date: Thu, 01 Oct 2026 13:42:36 +0400
Message-Id: <179084775652.2086187.10019299370073622313.b4-review@b4>
X-Developer-Signature: v=1; a=openpgp-sha256; l=625;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=eY9VzxEtB6C+NTsfWL84uGsPy8OOkFkaI/prBejoD+E=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqvisP2F6yagJvhYyVw8mxxJYO6CQRNNVn107Ry
 mwsWvd+xdaJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCar4rDwAKCRDa6OEJdZac
 5ev6D/4s5tkeEbCM6cpSHcWvHrBnzBOEh0EtlpgiNkFmI1eVJ2+xum4hiz74/xgAslmhkl87dtW
 sO3vn3oKHxTdXAAirtP3x/S2CtsN2FJbUofJr2rpCXCBDDjjOPrPtNdRaSI1Jk7Ra2LrszovVG+
 GzlqhKfncPMOF0W6n+AaIIz/wHaVoAbHFIyTUuwlrrgWRRfStkco6ekzCp1GgiDmrJWFX3KUfiG
 R6Cjvr/e2OFunf5y53bVF3Vw3EcB46/bj6qtpSemkdrKjAzqAAhgmnt8TShr0jzzdovEaCUfmDh
 Slj8By14AIDRE8iiuHBOrTibddQrEEdNKNZKScxfbQkzN9K1Ate16iame+iW9nF7EsxLrdldXPD
 ffR69oM+GEJ1bikFvLzBoapr9ynTXXPjCtJj1DLg0l50Zrgbenzd8RZwuhuChx3/rDUp3XQ/CpB
 18NPhg0NvXR5ZeKY71tk+uZr+Soh1zCdx3L5OCPMu2ZgRBPCcYXVHkuh/mGmPOKtMYrH2nCcrLZ
 feAG38mbjyHO4psvXNAQm2Ue6holQl9+vk78L42igERaxgNItCUzlAL1PKFe+j5a0PuFyJZmQ0k
 42cZx1qa1EFbSVzsImXlDdPi92+1x3SvkPEDxBdaAy6iXnfpXHEmy8oQfFbufY6SnDSVNTuEzPw
 exIfqY3RQMYB7KQ==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.341,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Wed, 30 Sep 2026 19:10:59 -0300, Fabiano Rosas <farosas@suse.de> wrote:
> Currently the qemu_opts_parse and qemu_opts_parse_noisily functions
> are called in one two ways:
> 
> 1) qemu_opts_parse|_noisily(&some_group_list, ...)
> 2) qemu_opts_parse|_noisily(qemu_find_opts("some_opt"), ...)
> 
> The second form is problematic. Having the result of qemu_find_opts()
> going directly into the first argument makes it difficult to handle a
> possible NULL pointer retuned by it.
> 
> [...]

Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>

-- 
Marc-André Lureau <marcandre.lureau@redhat.com>


