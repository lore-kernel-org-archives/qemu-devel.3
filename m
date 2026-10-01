Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85BC9CA5FB3
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Oct 2026 09:44:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xCDJi-0005yv-EG; Thu, 01 Oct 2026 05:43:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1xCDJg-0005yk-Kj
 for qemu-devel@nongnu.org; Thu, 01 Oct 2026 05:43:04 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1xCDJf-0003N2-1P
 for qemu-devel@nongnu.org; Thu, 01 Oct 2026 05:43:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1790847782;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=OMJKN+Z243RuO1AhdvJsocv5PY5II02U4L7p77LDRFM=;
 b=MrbJeNfuC+mBQh2NsJSWEDXrlwiIHdePozdFGe96BabaLlNlH1SzjJRiHSvIPOtqXkcmL4
 udemRjJa7Olfh0mmPPOYvk2RHgpNsa2XhKcGkVJYlYx1QGcS237v/klAMYfCD/z/GnkTnl
 yooa7KxIkM7H7Y3f9f3YnO/9orpBRSM=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-170-mvEvsdfJM5uPMIdgdawEsQ-1; Thu,
 01 Oct 2026 05:43:01 -0400
X-MC-Unique: mvEvsdfJM5uPMIdgdawEsQ-1
X-Mimecast-MFC-AGG-ID: mvEvsdfJM5uPMIdgdawEsQ_1790847780
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 442F319540C5; Thu,  1 Oct 2026 09:43:00 +0000 (UTC)
Received: from localhost (headnet05.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.117])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 7A3CE214; Thu,  1 Oct 2026 09:42:58 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 06/11] qemu-option: Change qemu_parse_opts() to take
 the group name
From: marcandre.lureau@redhat.com
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>, 
 =?utf-8?q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, Michael Roth <michael.roth@amd.com>
In-Reply-To: <20260930221105.2262063-7-farosas@suse.de>
References: <20260930221105.2262063-1-farosas@suse.de>
 <20260930221105.2262063-7-farosas@suse.de>
Date: Thu, 01 Oct 2026 13:42:36 +0400
Message-Id: <179084775654.2086187.16818170361024211084.b4-review@b4>
X-Developer-Signature: v=1; a=openpgp-sha256; l=458;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=2v6NnV3syLXHxBukhYr//3jBAK0uI65U7mynQPy1urc=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqvisPZORaw9cjwZ7Fl78Bl8HCxOJkudMxlRlsP
 brUR0xIuYaJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCar4rDwAKCRDa6OEJdZac
 5ddVEACXGcQIHjjro2NMlmR1KtkCQwvJ3L76kpCtiiKS/6x4fLKXcx8Jw8SH+a7EOLXvB9pHdwH
 MzvI+3bAJRl0uLw1QDG3EIT/2exCyFRh1yoQ1+Ij7wKAD6Lzrhs65HUSIYnlgvxAjsfPB6U4D7H
 qxbaCMtYfPvBr85THO3zFciDpGBA7JWwuC61BbmsckgNzfnoGLkye3Nw2i8+piWydBV5HF7F9Bk
 M45zUycUtyIWYz65kApDTcsjwQKeSxm8QCrX7q8yfZGd9o7TtMyuBN1QFfiFiDFK7YH8+UGcjUV
 Drab6otZBmeCN8bMIso1KFtXswLL6lxAmmJ0IelR0EtCWz8dJ+InEoTYFWVcnSPUs/XPGb2JyR9
 o09xppIZV5X8DjLyFH8Xriu88+omJS1dEbLJt+w7JQcWfnvOdNm1W25J9+WfBQCUngwIeTMgbWu
 X02I+BAhAFuZYppbnCzxtgqxcU/fBySIAtc4xx2ZdzRsRKw+a6hzcld1q+11JICjbhnedzLrFGs
 ZP62SwzwL87yoBiTr5JlIy49aV9VkrALqUh+foAvp5rcQwp3bSxS3NmBWmE5N5SG/Jbw2dsDiBr
 dn9yvjMQ2ETww6vJqj24PMsBd+3agjNrVQCkTMaO5c8PLALWH6fXkjRTZ0lcYfIi9sLRcr3lM9l
 +YW/2C2ixE/x6BQ==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 9
X-Spam_score: 0.9
X-Spam_bar: /
X-Spam_report: (0.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.341,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Wed, 30 Sep 2026 19:11:00 -0300, Fabiano Rosas <farosas@suse.de> wrote:
> Get rid of the pattern qemu_parse_opts(qemu_find_opts("some-opt")) by
> passing the string directly to qemu_parse_opts().
> 
> Don't check for NULL list at this time to preserve the old behavior. A
> subsequent patch will correct that.
> 
> 
> [...]

Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>

-- 
Marc-André Lureau <marcandre.lureau@redhat.com>


