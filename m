Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E837CA5FCE
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Oct 2026 09:00:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xDeYB-000212-9j; Mon, 05 Oct 2026 05:00:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1xDeXw-0001sE-GP
 for qemu-devel@nongnu.org; Mon, 05 Oct 2026 04:59:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1xDeXs-0002ZL-Tm
 for qemu-devel@nongnu.org; Mon, 05 Oct 2026 04:59:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1791190778;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ysJAfzK3K+jtbZHR++4TL9rAjDFPuFiXdwDn4sfpl8g=;
 b=H+4zt9nTRoXH09czMfqz3V6kE3NaMKm63yFf8qZj5jq6Dj/gwqMxSCV/MO/IJyxwaD9WWf
 r2VPIQSaegMMy7guhQZvfoEpnI59Xuc/KFMJmQG24+6f5I5XACdFqzldxKOTEAmkxvW/B7
 WeL9XGYhZ3jLVCeszgPsHLePGpYlZhg=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-465-D8UFcrObOTCRIsQB0ZSMjw-1; Mon,
 05 Oct 2026 04:59:33 -0400
X-MC-Unique: D8UFcrObOTCRIsQB0ZSMjw-1
X-Mimecast-MFC-AGG-ID: D8UFcrObOTCRIsQB0ZSMjw_1791190771
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 91A2D192DD43; Mon,  5 Oct 2026 08:59:30 +0000 (UTC)
Received: from localhost (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 41EFF180034F; Mon,  5 Oct 2026 08:59:28 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 1/8] hw/usb/bus: Let a bus opt out of automatic hub
 insertion
From: marcandre.lureau@redhat.com
To: Jamin Lin <jamin_lin@aspeedtech.com>
Cc: clg@kaod.org, Peter Maydell <peter.maydell@linaro.org>, 
 Steven Lee <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>, 
 Kane Chen <kane_chen@aspeedtech.com>, 
 Andrew Jeffery <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, 
 "open list:ASPEED BMCs" <qemu-arm@nongnu.org>, 
 "open list:All patches CC here" <qemu-devel@nongnu.org>, 
 Troy Lee <troy_lee@aspeedtech.com>
In-Reply-To: <20261005032022.3980903-2-jamin_lin@aspeedtech.com>
References: <20261005032022.3980903-1-jamin_lin@aspeedtech.com>
 <20261005032022.3980903-2-jamin_lin@aspeedtech.com>
Date: Mon, 05 Oct 2026 12:59:18 +0400
Message-Id: <179119075844.699310.3804663024357394088.b4-review@b4>
X-Developer-Signature: v=1; a=openpgp-sha256; l=622;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=mYy9+gp/VqkOED6+0IYAkDDFYpGmHc9xof6PsGYEFUw=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqw2bpQsHQqCsCq9VeaKjFSq+7z7Hx4pSz6nhF6
 jLynFQVngOJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCasNm6QAKCRDa6OEJdZac
 5cBbD/90orOhKj/0NCTHozKjlZUc/Vj66hN/Mu0HXnuU/+Q8/W8HqkYSpD1SVaTOpRGERfnCbLT
 agRkjUire3kVENGQev+R+pczsoqHG01LC3DwHwhV1I9HUz0KpmAa9M8ZxQ7yXTvLRylpx+wGB1q
 GwUXe7ONVnwVoj66Wina99pjFkx2KsboKuryltYccjK3gA721bO0vWupR35e41uHF9uuHpCIjGh
 fJmhBzk0ybQ9+Sd6paM8sxRLZDeE9rd1skyCFc6I74rWajWh+Ooh0d2jNkBF2Mc+BU+vSI99TS6
 07Qr4WuMEWKgJ9rvOhOg3Ae6BdyvQDwOcNOISiWbV0g0EfPM+NzSRU4gpWEq+WR1k+XdOrUidA/
 v8X9PvAojofi+Uthr+13bicHon11wsTdGCE05wPUWBTv/VG1ZxuWYmP5SpnHoZWHzkPSjzIROBP
 WpYbDCbSVw/LYB+gC0iWsaejTHUkX2UY2ikRIkW+Gng/UpzjiuB84YyuvgOBS1QBH9mMVqw90Rq
 QZ2OvxP5yEQaob9i40TmS5nuB0sBMmk2Qo9WuevG569kbcBOGjK1FUp5cdnqtPH+zsFUWblV6Ml
 ZUl3iO4s0/e6+/GicOo+HkVvHNQxHNlESiB/9BpfbKqeQr3B/sdKVGMz0JP1NzmU+dr8vDLOBxk
 M4bYrtqcpIuZUuw==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 10
X-Spam_score: 1.0
X-Spam_bar: +
X-Spam_report: (1.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.24,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.01, RCVD_IN_SBL_CSS=3.335,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On Mon, 05 Oct 2026 03:20:24 +0000, Jamin Lin <jamin_lin@aspeedtech.com> wrote:
> usb_claim_port() inserts a usb-hub when a device is plugged in and only
> one port is still free, so that more devices can follow. That is what a
> host controller with root ports wants.
> 
> It is wrong for a transport that carries exactly one device. The hub
> takes the last port, and the device that was being plugged in ends up
> behind the hub instead of on the port the controller watches.
> 
> [...]

Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>

-- 
Marc-André Lureau <marcandre.lureau@redhat.com>


