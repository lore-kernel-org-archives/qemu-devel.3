Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9BA70CC6B3C
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2026 12:16:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xHKNl-0000Ky-Po; Thu, 15 Oct 2026 08:16:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1xHKNd-0000IV-Lk
 for qemu-devel@nongnu.org; Thu, 15 Oct 2026 08:16:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1xHKNc-0004NG-Ao
 for qemu-devel@nongnu.org; Thu, 15 Oct 2026 08:16:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1792066575;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=BIGtBxsMgo4mzXhxvxaJPKn7j9kGhkSQsCheJ/J+4m4=;
 b=O+lruNrC7zJ46rU5QTaoQ0fHHymBBmWaQdgzx0m0eLWFh4DQu84XH7qV/RMQLRuovvnxVT
 bXxdxSmzVYmqQXL26L70uDTr5xG8TSMp+G2fdkjaq5N/s4NjsalyQLL7nRlgld7QsoneU5
 gXDuBXOH0Wb+f4gxH0O72U+bPIA7Ef8=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-399-bWsoum5AOHOoSUp_T34EPg-1; Thu,
 15 Oct 2026 12:16:11 +0000
X-MC-Unique: bWsoum5AOHOoSUp_T34EPg-1
X-Mimecast-MFC-AGG-ID: bWsoum5AOHOoSUp_T34EPg_1792066569
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 459B4195606E; Thu, 15 Oct 2026 12:16:09 +0000 (UTC)
Received: from localhost (headnet05.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.117])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 055F830001B9; Thu, 15 Oct 2026 12:16:07 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH 03/21] system: rename qemu_init_sigbus to
 qemu_init_crash_signals
From: marcandre.lureau@redhat.com
To: =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 Michael Roth <michael.roth@amd.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>, 
 Fabiano Rosas <farosas@suse.de>, 
 Richard Henderson <richard.henderson@linaro.org>, 
 "Dr. David Alan Gilbert" <dave@treblig.org>, 
 Paolo Bonzini <pbonzini@redhat.com>, Markus Armbruster <armbru@redhat.com>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 Eric Blake <eblake@redhat.com>, Laurent Vivier <lvivier@redhat.com>
In-Reply-To: <20261015112044.1999748-4-berrange@redhat.com>
References: <20261015112044.1999748-1-berrange@redhat.com>
 <20261015112044.1999748-4-berrange@redhat.com>
Date: Thu, 15 Oct 2026 16:15:52 +0400
Message-Id: <179206655290.744241.2055149713021359811.b4-review@b4>
X-Developer-Signature: v=1; a=openpgp-sha256; l=357;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=2w5JuaP31iQrR6h6ud7++3GdHnxDl0dg8bfWhID/jQQ=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBq0MP9ePgW35pQ9/59QrUdM0F65QjA6YVZEk5Y3
 6u39/DwgFeJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCatDD/QAKCRDa6OEJdZac
 5UFvD/9c0OTNkfuGvfmmSFLiwPJDvdJWTxUjnXcPhOUSNEyoSYlaeAEUcK8d6kFLBTIZEo5Fym2
 BjG/J3f55WM/+Vz1ZrPaJsFVzDJwVhEDriahH+HHjrHIbxcccToDAXFvSk4nQcDoNj9o/OW5/JE
 1E35HN7pwlC3f9F/EUz90skwACauQpAruLap2aCwIGP1TYj7Uonn2kTxb1Y//RTeMLqgT3floSv
 tmyKJ9WZZn+7aDrkvlHcs5DbopTwdpdzdpt+/zuWwKJ2NQ71tC6OQTaPEelTh+2VcQ1hMUJc7QT
 Il0yvgPVolyKJewkWHbV+Bwxle9UkOxKiuldhPmzkYb9YKbgpoyDR9FBexfvDKn6qcZz+Qeeo68
 +A1dQ7zVP70pACjmkCmKHb42KGa1/OYznOsp0ysibFTzpk34H+nEgVTfrMAWDi36sZ002DkQQvu
 rGSfDByFfHsv2D62sRTAWlL/5DMCt0565lAc+EaVQQS2wOqAgwKYYWzwpriz6NPntPPpqw3wIKi
 RarnXH8F1pfWBtefFd+fRPIsKUDytSSoBeBpoHMnsXmbyReloC1heLjhPf7mkXYFrZyyxSR4gnP
 //rqwOCKlMXfpj2auOYM754aZdZt9nsElpgQFxghKuFnC0CgyDkAwjoTx6CUv6rKLGLTskWh7NI
 rMPP9TpmAOYtjRg==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 10
X-Spam_score: 1.0
X-Spam_bar: +
X-Spam_report: (1.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.24,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
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

On Thu, 15 Oct 2026 12:20:26 +0100, Daniel P. Berrangé <berrange@redhat.com> wrote:
> Support for handling further crash signals will be introduced
> in subsequent commits, so remove 'sigbus' from the initializer
> function name.

Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>

-- 
Marc-André Lureau <marcandre.lureau@redhat.com>


