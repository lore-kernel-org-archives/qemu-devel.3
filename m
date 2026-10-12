Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C352ACA9ED0
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Oct 2026 21:54:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xGNxV-0000cL-G2; Mon, 12 Oct 2026 17:53:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1xGNxT-0000aE-It
 for qemu-devel@nongnu.org; Mon, 12 Oct 2026 17:53:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1xGNxR-0006TG-Me
 for qemu-devel@nongnu.org; Mon, 12 Oct 2026 17:53:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1791842001;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=SseXWh6R0u0fjf3MDwSq5j+z/YgbHixJ4M/YEJBxOds=;
 b=eehKoJYk/mQw3eyYlZ7xRTtnWNGrBDfhB4glrPGGmVqO5Sxg8PGabS0+/T1/q1deS+I+qP
 j/awjg7N0adqbWOqwTM2JJxzvYFd1A1zs7JRKDUaP+n10pXAe9VzeYhhapMTW4G370luIU
 hY5RZaVouzD8cyR5//IjRge3E5CN00U=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-640-FAC79Y0GMKy5gst8fTJfhQ-1; Mon,
 12 Oct 2026 21:53:11 +0000
X-MC-Unique: FAC79Y0GMKy5gst8fTJfhQ-1
X-Mimecast-MFC-AGG-ID: FAC79Y0GMKy5gst8fTJfhQ_1791841988
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 0EFAA1955F2E; Mon, 12 Oct 2026 21:53:08 +0000 (UTC)
Received: from localhost (headnet03.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.114])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 3B9141956040; Mon, 12 Oct 2026 21:53:04 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 16/16] tests/functional: add tuxrun kvm gdb test for
 s390x
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
In-Reply-To: <20261012170330.1144446-17-alex.bennee@linaro.org>
References: <20261012170330.1144446-1-alex.bennee@linaro.org>
 <20261012170330.1144446-17-alex.bennee@linaro.org>
Date: Tue, 13 Oct 2026 01:52:29 +0400
Message-Id: <179184194937.2190936.2758967581839805011.b4-review@b4>
X-Developer-Signature: v=1; a=openpgp-sha256; l=2616;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=5oOBvLyUpfcVIMzxeGYmvUpfEw7pQvf4mzTtSd478lc=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqzVagcmQ7hbJyA+il7perfKuYVzp4Y2qC/J8iH
 +vcVDJpLOiJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCas1WoAAKCRDa6OEJdZac
 5U9tEACP0pQUezMgYczWupowrC3ZnVC1NVl0FefbKbxqGqE61cB4kShWfJW4nxmvjvdMdj8i/VH
 Hewnvg1GxYOyngOwgY5+xRrRFG6HIW/ZasKVDZEG3uow3eSgzDthRWvxSq+/y5IAWWqh1DhHu9D
 J52dAiLQ+0gOXjwjAcDtuU8ItnBvIlIhS/V3KtLzKlgjyeBpaYR6sFEJl+EpTll4G6OxJSfCo+4
 TbcIgDgE76AhlQ04Ppi/4IY/UczR24MEi46nbcWQh3XHBjhkfivtCZElfRzVGHIzcTGbbapdDAa
 gzXKXPEjYwDAZX0aafrYvPnaOKx4pmtTiK+V75/9NSFianMS803NXsQxMPs3zqmWHqPG9Hnm63M
 5Xg2szKo7lwZxx1Y12CCMhcSp7pcoZOZ/mZtk/pJ88k/tHCQyblCmIn51vqKTRV3gJXYZvkc9Qe
 T4QpSySLbUpx6zDzcoxiph8MYIA4rbfcnXoOd7IbhrLKYjE6QHkSk8EV1MULCouT5gFffHEX3LM
 tPBD6vuAcofFHxZkxLBqlorHipOLW2Rh46e6l5Mvd1fDxSMhrM6utGIejEhjldXeNwhDtz5MeJr
 PC04KyrxhO3ltZrqMjJTGCQQl2nCpVSVJUHHjGILwxloXo628YCqERPwoPgBRldzivt8FL0ppCa
 q6FvTDoJQbNOMFQ==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 10
X-Spam_score: 1.0
X-Spam_bar: +
X-Spam_report: (1.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.24,
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

> As with x86_64 we now have the bits to add a KVM gdb test. One minor
> wrinkle is the s390x only supports WP_WRITE watch points so we skip
> the other watch point tests lest we get confusing messages about
> failing to insert HW breakpoints.
> 
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> Message-ID: <20261012170330.1144446-17-alex.bennee@linaro.org>
>
> diff --git a/tests/functional/gdb-scripts/kernel_gdb_test.py b/tests/functional/gdb-scripts/kernel_gdb_test.py
> index 2d62fe01f10c..56f0514c9432 100644
> --- a/tests/functional/gdb-scripts/kernel_gdb_test.py
> +++ b/tests/functional/gdb-scripts/kernel_gdb_test.py
> @@ -107,11 +107,13 @@ def do_one_watch(sym, wtype, text):
>  def check_watches(sym_name):
>      "Watch a symbol for any access."
>  
> -    # Should hit for any read
> -    do_one_watch(sym_name, gdb.WP_ACCESS, "awatch")
> +    # s390 only supports write watchpoints
> +    if "s390" not in gdb.selected_frame().architecture().name():
> +        # Should hit for any read
> +        do_one_watch(sym_name, gdb.WP_ACCESS, "awatch")
>  
> -    # Again should hit for reads
> -    do_one_watch(sym_name, gdb.WP_READ, "rwatch")
> +        # Again should hit for reads
> +        do_one_watch(sym_name, gdb.WP_READ, "rwatch")
>  
>      # Finally when it is written
>      do_one_watch(sym_name, gdb.WP_WRITE, "watch")
> diff --git a/tests/functional/s390x/test_tuxrun.py b/tests/functional/s390x/test_tuxrun.py
> index 8e0261e2b7fc..528af3c08ff0 100755
> --- a/tests/functional/s390x/test_tuxrun.py
> +++ b/tests/functional/s390x/test_tuxrun.py
> @@ -19,6 +19,9 @@ class TuxRunS390xTest(TuxRunBaselineTest):
>      ASSET_S390X_KERNEL = Asset(
>          'https://storage.tuxboot.com/kernels/6.18.54/s390/bzImage',
>          '5efeb31754b211440e1595ab11355bb006fe78a2c0604ed0a8c55c4598b71aec')
> +    ASSET_S390X_VMLINUX = Asset(
> +        'https://storage.tuxboot.com/kernels/6.18.54/s390/vmlinux.xz',
> +        '5bbd4d34e0950f88053a9bfd16078896df4b1ee1696fc2ad62488e681a6bdd8e')
>      ASSET_S390X_ROOTFS = Asset(
>          'https://storage.tuxboot.com/buildroot/20260924/s390/rootfs.ext4.zst',
>          '5ba18c4d18831c50a0c743990f7bdee1d3b520629d423c55b668d8fbbac9c6f5')
> @@ -42,5 +45,16 @@ def test_s390_kvm(self):
>                             haltmsg="Requesting system halt",
>                             accel="kvm")
>  
> +    def test_s390_kvm_gdb(self):

Missing @skipIfMissingEnv("QEMU_TEST_GDB") decorator, which the x86_64
and arm64 versions both have

-- 
Marc-André Lureau <marcandre.lureau@redhat.com>


