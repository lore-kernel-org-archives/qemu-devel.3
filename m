Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E72A6CA5FC4
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2026 21:33:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xC1vV-0003Pg-OY; Wed, 30 Sep 2026 17:33:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1xC1vU-0003PS-GM
 for qemu-devel@nongnu.org; Wed, 30 Sep 2026 17:33:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1xC1vT-0001pr-07
 for qemu-devel@nongnu.org; Wed, 30 Sep 2026 17:33:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1790803997;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xTTHq61Hg62PVCUSJbfEizgENUuRbgoqLgmJhs68T3s=;
 b=MJ/PxpqpdTHFVdBgnfErm5QYse97nzCvCRtXNCim5yyx9KHcwSbxBL5/sFNGEhT74exqrO
 2rNclGMFcCn7tNHqY72DSFoUIUSJcwvJZmvv0GAFF/9RYLNBgLFvIL6LKtgAlPG0toToDH
 0Z3+pd/WFuKYIhhbomN0wDG1tr2aC7k=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-121-9cgYKs47Pwqgee9P_hg9aQ-1; Wed,
 30 Sep 2026 17:33:12 -0400
X-MC-Unique: 9cgYKs47Pwqgee9P_hg9aQ-1
X-Mimecast-MFC-AGG-ID: 9cgYKs47Pwqgee9P_hg9aQ_1790803990
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 8E091180B5D7; Wed, 30 Sep 2026 21:33:10 +0000 (UTC)
Received: from localhost (headnet05.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.117])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 8FE88180056E; Wed, 30 Sep 2026 21:33:09 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 00/21] multi-target: add straightforward architectures
From: marcandre.lureau@redhat.com
To: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org, Richard Henderson <richard.henderson@linaro.org>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260930020108.217892-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260930020108.217892-1-pierrick.bouvier@oss.qualcomm.com>
Date: Thu, 01 Oct 2026 01:33:04 +0400
Message-Id: <179080398404.1695325.14681269818208184948.b4-review@b4>
X-Developer-Signature: v=1; a=openpgp-sha256; l=520;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=Jqixqcn3Yfsa+DUUeV2ZiA3pUwoLhqopP/a9AXepTpA=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqvYASwh1+oFdO6lp0zJeDDYhVk6w28V9gNKA6h
 T40nThEFHiJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCar2AEgAKCRDa6OEJdZac
 5WkED/0ec+OmZa3AHvTdpKQVT80Nr/kl8QjE2lzXgx9zOMPH5octTm6TaB8x/enplVzO32bPSk7
 yFR5Qt9i93mFN1BnJy2VBAklj35dHOfVZ2g5aFZR4yvV/A6/rHjIiVuoapEsLaFK5tkfC/t14rl
 f6J2z1NJFL0SNSxhBNz1UB3E1KHHXyBkhrDEkM/QWyOJF+Ua+YamUwnZGHBbCKs2LJnt2Ki/CtP
 5rIiogK/wARUCBA37H5wUYrt45JGXitTFFZFHqNnbyGsSPIhCNUSRgQrmBZzu3iWND+DQhbGiqE
 BYdegK2FP5OxHCgLMTlj90pAp5k4ZJZwFC3iv22q1NCKdp+5/xWile0UR6Ny4D3rhWGOQhc9mYu
 lBexjtji5MPey9SrkhivoloN0Ud/GsOhlqJ5fKDYAmgO8gntUHcV8rpSaw4nx7kedkfyWf5JZUo
 p0R6GImsH1I7FyA+khvvESoi/FCMSy4k7YzX6FYVCXCrITDU6g61+ztdtZsReQqqsXIgKFpwVAP
 GYr+OJIxTqiRItXqBIq73M854MmLj1W7tQc04HM/zxjCao7AaBM6mBlGqgsvR1iZdCw5YPW5kqC
 ihAfQGCoKckH5XmSPtwk0pkWEDjoUccRpIharxj9VfRxQnYagGlotM7SBNpSK/ryA9jUw9DWcCs
 TK8IaxGeuU3Lo6g==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.341,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Wed, 30 Sep 2026 02:00:47 +0000, Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com> wrote:
> multi-target: add straightforward architectures
> 
> This series adds all architectures that only require stubs, basic helpers
> renaming, or filtering to be included in multi-target binary.
> 
> List:
> - alpha
> - microblaze
> - m68k
> - hppa
> - rx
> - tricore
> - or1k
> 
> [...]

Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>

-- 
Marc-André Lureau <marcandre.lureau@redhat.com>


