Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A15ACA5FCB
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Oct 2026 11:20:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xCEpF-0000Fh-Of; Thu, 01 Oct 2026 07:19:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1xCEpE-00009Y-A5
 for qemu-devel@nongnu.org; Thu, 01 Oct 2026 07:19:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1xCEpC-0006PT-VW
 for qemu-devel@nongnu.org; Thu, 01 Oct 2026 07:19:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1790853582;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XFx/t9mrsXH6YarujWO+vCAcCXE/LsovmrFJgKG/B9U=;
 b=jO6D2Rmjb125oGsstVVRMDVQqd/f/AMxRFlAmO/8yboXFZoWagnDs4iKRJ/GoQh5K1g+mD
 4hQi9XOM/rDp471tL6S4VV7qWLbs5gI+cwUVtGPq/g/cFkcIGXt5HdolMDGYzY2vOaGbrp
 A0iVo17qv0aSSCW3HkS77dwYQkoZoxM=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-450-2HV03222MuSNDPtF07Gz8Q-1; Thu,
 01 Oct 2026 07:19:38 -0400
X-MC-Unique: 2HV03222MuSNDPtF07Gz8Q-1
X-Mimecast-MFC-AGG-ID: 2HV03222MuSNDPtF07Gz8Q_1790853576
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 9624B1953942; Thu,  1 Oct 2026 11:19:35 +0000 (UTC)
Received: from localhost (headnet05.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.117])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 735541956095; Thu,  1 Oct 2026 11:19:34 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH 10/13] tests/guest-debug: add --kargs option to
 run-test
From: marcandre.lureau@redhat.com
To: =?utf-8?q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, Kyle Evans <kevans@freebsd.org>, 
 Song Gao <gaosong@loongson.cn>, Ani Sinha <anisinha@redhat.com>, 
 Warner Losh <imp@bsdimp.com>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 Richard Henderson <richard.henderson@linaro.org>, 
 John Snow <jsnow@redhat.com>, Keith Busch <kbusch@kernel.org>, 
 Cornelia Huck <cohuck@redhat.com>, Thomas Huth <th.huth+qemu@posteo.eu>, 
 Zhao Liu <zhao1.liu@intel.com>, Peter Maydell <peter.maydell@linaro.org>, 
 Laurent Vivier <laurent@vivier.eu>, Brad Smith <brad@comstyle.com>, 
 Peter Xu <peterx@redhat.com>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Ilya Leoshkevich <iii@linux.ibm.com>, 
 Matthew Rosato <mjrosato@linux.ibm.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>, 
 Eric Farman <farman@linux.ibm.com>, 
 Anders Roxell <anders.roxell@linaro.org>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 Brian Cain <brian.cain@oss.qualcomm.com>, Klaus Jensen <its@irrelevant.dk>
In-Reply-To: <20260930164649.433573-11-alex.bennee@linaro.org>
References: <20260930164649.433573-1-alex.bennee@linaro.org>
 <20260930164649.433573-11-alex.bennee@linaro.org>
Date: Thu, 01 Oct 2026 15:18:52 +0400
Message-Id: <179085353203.2170790.14889873774163155791.b4-review@b4>
X-Developer-Signature: v=1; a=openpgp-sha256; l=418;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=prjud92xUckoOOFuZCG/0MVqz0Iz0HlAjCP7KlAVYEM=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqvkGepVzD3JRQe4N8ifDeUd9cHC/QBF+AJUpn2
 87kGYcdktmJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCar5BngAKCRDa6OEJdZac
 5avEEACAeR7X0EG5uFIPOTqCZla3SsPuYssMOHhb5u3Sh1qR5Vrlj53fs5t5/vto3F2AeQKyd4v
 uF9YfQa9HIelemCXhywzd5lu0reRjpuujouFdZFwGsICFnw85BJEj3DhmzS3P+hR4HXlWMkrqHn
 rzsH3tK1ypKP/ESCLW0S/tJvvpLlofg8m6i5sgXb01t9GW1i5+NLrWll5eKQTfaCQavMfxXAlHL
 vUpKM86FXv7s9QQaa2jR27B3SihrJY3l03PoFFdtrJAhH8TVTa3GnBgox8IL7UjM0Lv5oj/9/zC
 faoHozwbLmzgjJkh0kUdOB8HYjhbAssrj5XksX/FXoAFSHbDc8vyiTbZrmH0yAb2dMVcFPdOw4E
 raQtqGyTnsS8O0Itz6kXnjXLLyo6eiyaMw4Bw9jS6Z8r44YTq9HAwP3/0qRClu34WmwzLjwuU/6
 rGipcyvWv3B4MQU4eTjjut7Pgvg1MkZNuCcoTta94LlyZPRI2mwDPE2QRIGq1QlfI6YvbKr/jYK
 t0GMFaqmClS3k7UMKbDWX4FNaDNfz/1wjwSuTDGrHQSPxC5acYs837clJRv8gw83A76Jo/bqjuH
 NcWaBvfpDcEUFWyOPmIPaF/m64A/KSlzqr6zlhobkLxubST+Rg3jQeZ6xzLsgRg6xuDEDpxom9s
 NC0hi1m5kLI3AxA==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 9
X-Spam_score: 0.9
X-Spam_bar: /
X-Spam_report: (0.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.331,
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

On Wed, 30 Sep 2026 17:46:46 +0100, Alex Bennée <alex.bennee@linaro.org> wrote:
> When passing kernel arguments to QEMU with --append we need to take
> care that things are properly escaped. It's easier if we get the run
> script to do it for us that constructed the nested escaped --qargs.

Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>

-- 
Marc-André Lureau <marcandre.lureau@redhat.com>


