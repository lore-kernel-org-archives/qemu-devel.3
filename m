Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44CB8CA9EC5
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Oct 2026 21:54:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xGNxD-0000UI-77; Mon, 12 Oct 2026 17:53:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1xGNxB-0000TE-Dc
 for qemu-devel@nongnu.org; Mon, 12 Oct 2026 17:53:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1xGNxA-0006Pl-1v
 for qemu-devel@nongnu.org; Mon, 12 Oct 2026 17:53:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1791841983;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=x4iqiWKkdRpY9Q/RhKNFFfw8qRIJ87Igt70jRYdwTRo=;
 b=bGGKV5jlEAOiny4BS6zFvCRUVB5z+qQc/AWJHXQqYkjWh6giofTkZwBu1wvySvZ4dvZJed
 Gd5k1dKD4zQWsHcaqNHBuU7bZGflD+cYQmrx88KvYyeP6Qm3OZIx+156yGvcBeLlJGycac
 64zP9aSrgZZzoJAhrYUm/zcO1CKksAM=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-297-hUle2ROgMbKegx6emwB7DA-1; Mon,
 12 Oct 2026 21:52:59 +0000
X-MC-Unique: hUle2ROgMbKegx6emwB7DA-1
X-Mimecast-MFC-AGG-ID: hUle2ROgMbKegx6emwB7DA_1791841976
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D6F2A180057C; Mon, 12 Oct 2026 21:52:55 +0000 (UTC)
Received: from localhost (headnet03.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.114])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id AC7E318005AE; Mon, 12 Oct 2026 21:52:53 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 13/16] tests/functional: add tuxrun kvm gdb test for
 arm64
From: marcandre.lureau@redhat.com
To: =?utf-8?q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>, 
 Zhao Liu <zhao1.liu@intel.com>, Kyle Evans <kevans@freebsd.org>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Brian Cain <brian.cain@oss.qualcomm.com>, 
 Richard Henderson <richard.henderson@linaro.org>, 
 Brad Smith <brad@comstyle.com>, Ani Sinha <anisinha@redhat.com>, 
 Christian Borntraeger <borntraeger@linux.ibm.com>, 
 Thomas Huth <th.huth+qemu@posteo.eu>, Keith Busch <kbusch@kernel.org>, 
 Matthew Rosato <mjrosato@linux.ibm.com>, Cornelia Huck <cohuck@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, Halil Pasic <pasic@linux.ibm.com>, 
 John Snow <jsnow@redhat.com>, Eric Farman <farman@linux.ibm.com>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 Anders Roxell <anders.roxell@linaro.org>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>, Warner Losh <imp@bsdimp.com>, 
 qemu-arm@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, 
 Yoshinori Sato <yoshinori.sato@nifty.com>, Peter Xu <peterx@redhat.com>, 
 Klaus Jensen <its@irrelevant.dk>, Song Gao <gaosong@loongson.cn>, 
 qemu-s390x@nongnu.org, Laurent Vivier <laurent@vivier.eu>, 
 Ilya Leoshkevich <iii@linux.ibm.com>
In-Reply-To: <20261012170330.1144446-14-alex.bennee@linaro.org>
References: <20261012170330.1144446-1-alex.bennee@linaro.org>
 <20261012170330.1144446-14-alex.bennee@linaro.org>
Date: Tue, 13 Oct 2026 01:52:29 +0400
Message-Id: <179184194934.2190936.15054221597476398433.b4-review@b4>
X-Developer-Signature: v=1; a=openpgp-sha256; l=265;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=Lw7LOumzPMJ/p1Cke3TYnD6IHVGeqQagWGxtRmyNpRQ=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqzVaf6mfuz4Jpzjd1SW/6fsK2JLTeKXM53Y4dK
 XAPBpae2raJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCas1WnwAKCRDa6OEJdZac
 5ZqREACOaOyRDYzYxIY1W7ERl7oGB5cThPBQppXchgzITz/c6dTWAgjKrYO/1KK2fWQ0QLhD4KF
 DuLHZWWlAc0HaiRir65QO9YnoUJP2bhNbgoqdVDio2ZUM+pRdni8DdQqR9dt4qEfJPOiBt0oJxH
 NLDIdC7FDbTD6jUfnjxaWB6AMtZPuGwt4cQNjHMHLe+UeK1Oy5PZ98v6YIHPThKDJFf+VAPiVEb
 24NaZAfdIQt/l1XhvyEjRCT4WB1CytRPTtVZ2UgLBezLQXAEYdMlD++OJWJ1rf+suhfWJzuRfTG
 c/Q4mHxYtPtt25tdZNV7gvLmezgnxBwfxdt6HYZr7XeaKucGqJA9t1g2jY7wch8jW3PHFn6tFbO
 Eavj3WYNTRmfau9vl1Ijyv8UnIZayBUUiAlYxCrJYkzItwUctl9T8xBoMdNnzHOdyjpKv93wXbc
 iS0i4hkPF/5W/V6iXAKTkfBFgH9XrQbAbnr90wHDPWppEL8BpNwmXx+NF+qOOUgAxWNFZ15/o1b
 EhI3BIYgIAjXDBA5ODToqomy7RmcUdsLHSX7Busm1f4qk0+23leKvnHobvHYL3SkhqrWTj51OVD
 QMXtXFdpEQysKA4P/j2bmH/1f7eHd+qNdMZomOa/8KEWv+thAxD32IXC4dukM51CuzBSMviSk6m
 z181V7eLHXoFfRA==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.24,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001,
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

On Mon, 12 Oct 2026 18:03:27 +0100, Alex Bennée <alex.bennee@linaro.org> wrote:
> As with x86_64 we now have the bits to add a KVM gdb test

Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>

-- 
Marc-André Lureau <marcandre.lureau@redhat.com>


