Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3C53606A31B
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Oct 2026 13:22:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=acYdmMHy
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xJ9mi-0001kx-0m; Tue, 20 Oct 2026 09:21:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1xJ9ma-0001kT-59
 for qemu-devel@nongnu.org; Tue, 20 Oct 2026 09:21:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1xJ9mJ-0002a5-Lp
 for qemu-devel@nongnu.org; Tue, 20 Oct 2026 09:21:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1792502477;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Ra1gCZcqcYCRpQtfVW2EpzbpcypDd4jR7IWHL5IrxkM=;
 b=acYdmMHy8ELuF6V1kBSmIBn/ZSMtKtwMlFWnUyRZhLgxG2AP0o3xlCBW+UJj+q1nDajPz7
 HMEAa+3t8EL/P+z9XZpvL5p+tRidLMxybyPvTrtOKepWD7cdIT4NJa1M/D+gxiGvq4l4vq
 Re/gNMEovLFg0Lg1WMN+yE+27cKClc8=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-564-YNPqXmNLO1u5Wv5ByIU1CQ-1; Tue,
 20 Oct 2026 13:21:12 +0000
X-MC-Unique: YNPqXmNLO1u5Wv5ByIU1CQ-1
X-Mimecast-MFC-AGG-ID: YNPqXmNLO1u5Wv5ByIU1CQ_1792502471
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 3A7011955DBC; Tue, 20 Oct 2026 13:21:11 +0000 (UTC)
Received: from localhost (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 190B91956095; Tue, 20 Oct 2026 13:21:09 +0000 (UTC)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v4 13/21] dump: reimplement cpu_get_dump_info using
 get_dump_info sysemu op
From: marcandre.lureau@redhat.com
To: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 anjo@rev.ng, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20261019212648.154493-14-pierrick.bouvier@oss.qualcomm.com>
References: <20261019212648.154493-1-pierrick.bouvier@oss.qualcomm.com>
 <20261019212648.154493-14-pierrick.bouvier@oss.qualcomm.com>
Date: Tue, 20 Oct 2026 17:21:04 +0400
Message-Id: <179250246425.3747302.11487396532415914250.b4-review@b4>
X-Developer-Signature: v=1; a=openpgp-sha256; l=712;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=lQidPClCUF6qKqQkxv1QYs7id/3MEDXEZHMk8GabqG8=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBq12rClZZZSBZB6UL4PqE5V6JdBXGKzkamlSriQ
 iRtNjN5XBOJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCatdqwgAKCRDa6OEJdZac
 5U1aEACjCRc3aXpMRzAaGGPXnJxdkkzFK67n8YddFsEaYNter4YGZayqVC89QKhBDiItgF0p2ah
 vp+TZqTpGDL5endbIoNc8saZJRipvJiHvV9kP+iEaxxCC89Ka5aVzHyYRL+o4tG7SqXf1palZZi
 0+/9qTaPvZbhCv2/9nZBL3M42NE9NTeovgXVtt3bJaBwgaKiDy5f+reU0klUziRuCGKan1Svh4m
 Y8IgdYORP2GalJED9ScI218EpoZJKo6rBIqYTbRjpbn9djhPtj2VIeM+yXLSxtcff0Ggl2oBZxh
 l/cJ4Fl9Qp3bc2SRp2zyzv02WDx7DL1BDmCe4TMmWRxcZNS1+kQDIBW/CayDgukiqmXc7TgfIHt
 AJtpHH20X/smlpOekRSewwF06AGzLjqtbFVGlEl+zgkiY28IO1Vs8rAUgm4yX1Fzt/azqfsZSty
 /Qsw6ysFkOOwxEvP7NJGOFc4yrDa/k6N/p6+vNcpZE8bdY+e3XW4v9gWs0+vvXiahibltI7PGVA
 o+NRYKb/lNMR5lcHJgM6teCs7x+CDnszVX+2MBTcDzix+RH1zRXrD7bs8Sg/0AdfwXZKKNB5iDc
 4iIQO5utBZoRxLYFDrAogurp4ATEVlWTnnumsW17uO9DhVF8c4TmRUKRjgeFXrCplA+dJAqUV5o
 9f0Imn2Ly1yEXGQ==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 9
X-Spam_score: 0.9
X-Spam_bar: /
X-Spam_report: (0.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.329,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On Mon, 19 Oct 2026 21:26:40 +0000, Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com> wrote:
> Now that all targets implement the get_dump_info sysemu op, we can
> replace the per-target cpu_get_dump_info() implementations (and its stub)
> with a single generic version in hw/core/cpu-system.c, taking the cpu as
> parameter, like other dump related sysemu ops wrappers.
> 
> We always check if there is at least one cpu available. For instance,
> machine null has no cpu present. Heterogeneous emulation is
> already handled by the check above which disable dump.
> 
> [...]

Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>

-- 
Marc-André Lureau <marcandre.lureau@redhat.com>


