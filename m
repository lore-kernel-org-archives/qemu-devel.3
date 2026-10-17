Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89452CCA462
	for <qemu-devel@archiver.kernel.org>; Sat, 17 Oct 2026 08:47:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xI01L-0001eq-GW; Sat, 17 Oct 2026 04:44:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1xI01J-0001eJ-UJ
 for qemu-devel@nongnu.org; Sat, 17 Oct 2026 04:44:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1xI01I-0007C9-Kq
 for qemu-devel@nongnu.org; Sat, 17 Oct 2026 04:44:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1792226640;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=C/npy+yBFX1XpurWuxpgTXI/h5ee2gpQnPmzCMuSq+0=;
 b=TNDCq1+2RWzPs77sFutqMAbngF6QsB3qZW0VWA21H1t+91/DjzXmlxr8OWnA1Z1Uj6M1JF
 r5aKepY29omIKJwMrKOSPsPSgJcyMRtTja8pEUrOz+/Ns/cG75VIopSzG8rABWTMVX1PA8
 wzvpFRaADO2eEghZ/91mlStgLQ6ohFo=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-642-mD4d86N2OQ6L0jXTJNi-sg-1; Sat,
 17 Oct 2026 08:43:52 +0000
X-MC-Unique: mD4d86N2OQ6L0jXTJNi-sg-1
X-Mimecast-MFC-AGG-ID: mD4d86N2OQ6L0jXTJNi-sg_1792226631
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 8F5B31800653; Sat, 17 Oct 2026 08:43:51 +0000 (UTC)
Received: from localhost (headnet05.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.117])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id B9D051956087; Sat, 17 Oct 2026 08:43:50 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v3 16/23] target/arm: implement get_note_size sysemu op
From: marcandre.lureau@redhat.com
To: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 anjo@rev.ng, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20261016181410.191743-17-pierrick.bouvier@oss.qualcomm.com>
References: <20261016181410.191743-1-pierrick.bouvier@oss.qualcomm.com>
 <20261016181410.191743-17-pierrick.bouvier@oss.qualcomm.com>
Date: Sat, 17 Oct 2026 12:42:49 +0400
Message-Id: <179222656906.1619676.8105073391428831494.b4-review@b4>
X-Developer-Signature: v=1; a=openpgp-sha256; l=284;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=9BbrTNTa5ZBmjedCel4EEBUf1Bi8lv6+Dy7dbRDQzNA=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBq0zUNnR3x/ubr/B/Mx/3j6mPKRFRchiZOvFOhi
 WIceZXEfryJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCatM1DQAKCRDa6OEJdZac
 5TkvEACJ2D2W10f4neT377UsjPBY5bZowmYrhc4cZKmlf1AC57egV56SnrlXfEzEXu0vsz7kYN3
 +mLEIG6FSLo2xHRO7MWLPn4/fvELT3uIHIzgp3TL62cA20Up2E3FhYEAS2STgeozFoixHfk6hkO
 dhdymKtQlgHOsuL8ka1e309Z5pTN9HcQFFRPEEmXCi8bdY11vzcfDfhT5A5YU5AnphXq6UKdtil
 kHUxliKPT3AWObgCxtzmy4xSFxYGXYkUiaPnqaDhKVjECuR8MVwU+ApchrelYJEpSx6jNB76LED
 3jH0BfOMs4gDbpCAbaDNJXIw8ol51YRS8oY8yvAcr8DlXt94s35lOJw13pYxkiN6GcpDWY1XIPn
 Cx6R25RUqiwN85IsdLY659yI7+cHUYIPX+kIP+nZz3J0QyWjGdhFFSzFB3+ZkD4bNUWibMRBnkX
 J+Uk+FhIf13KtQARsVGxjm5CVKQpyqcx1HM1nWaT3nmHpShyPxe7EglRm0M/eDSSB8CpTIAqoOU
 EpEF3233/ihmuGs3s1NHooDqCgY53j1qGh6k8iGWdoPCuiW+asGHj7mQ6j7fMHVKIesS+jpW/wm
 AeM65MtgVCCbczsQdVb83Sd2UTrH66jQsq/2EEarr+LIefxusDmGFW+W8h9AVp2uw8Tl8GEXmLo
 EB1z4EYEuT5yiUQ==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.24,
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

On Fri, 16 Oct 2026 11:14:03 -0700, Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com> wrote:
> For now, we keep the global cpu_get_note_size symbol defined.

Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>

-- 
Marc-André Lureau <marcandre.lureau@redhat.com>


