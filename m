Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D31BAC54E67
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Mar 2024 08:53:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rpP1s-00006C-CM; Wed, 27 Mar 2024 04:53:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <qemu_oss@crudebyte.com>)
 id 1rpP1q-00005k-At
 for qemu-devel@nongnu.org; Wed, 27 Mar 2024 04:53:02 -0400
Received: from kylie.crudebyte.com ([5.189.157.229])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <qemu_oss@crudebyte.com>)
 id 1rpP1o-0004ju-Pb
 for qemu-devel@nongnu.org; Wed, 27 Mar 2024 04:53:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=crudebyte.com; s=kylie; h=Content-Type:Content-Transfer-Encoding:
 MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
 Content-ID:Content-Description;
 bh=Mo04SwzJRirM/etuzgoo7EYZyAYiQ6E4CGT+DJfdlu4=; b=PVRwIp61vFyZ2G4Od9sBhJY6lP
 972tMzGNvgST/9fq5T2bCnfyxqEmyc6YEa2HxJuA4tj3M/rqrK7Xq4A7YYYI4zCZfAJ8rgF663tQq
 7a5bim5JarIuKXma5Y0zTPhxOaWPf3kQoR2UJOXv/1V0bWjoyaeJ5Ge5auFfwwCwzgbeYr/ArhBYl
 JAZmq8eWKNJQU7qOBadg5ZidE3LwC1qu3eQnqV6uZ56VNZeAIfleYQ8B6lc+vWoRbZ6B2cCxT8Uu9
 Pa/jS2fhIHk60wAIpWIbFBugalRhbuQ7DpRvIdnkqzdNvteEDbjJCtX4q/aHxCIM10LHf/2oetDX8
 fyGqBi0L8ny5H3FinNF25XaD6+78mC74T6f5iTN72QuC4WApTUZPEyjM+F8UOOMMGHeNXUmTp/tSB
 wSME//MpNZZ+AQTxbYtzGuEBqD758tUUeLhgkcp/3g6DkqRB+5kYPJ4Z3XxH8+AxcE0fydK9RGrm6
 AQqfBoBvTnImd9bsO7mEMpzI5XyExfhdSY90ZSpI5MrE8YAioOhuG78fuGw6L2IEA2hCN8/M9N9qN
 inSZsd8qvS03xMfhj7DpGU6VTXkYyQ4Hv7VLV23AWMjsHl1fxUuZwdA1isewLSRUv1hQIRWtUzNoW
 Fc3kUzDGn+z6MEHumqQmeOM82vkJnNZv0wtTsjiRk=;
From: Christian Schoenebeck <qemu_oss@crudebyte.com>
To: Greg Kurz <groug@kaod.org>, qemu-devel@nongnu.org
Cc: qemu-devel@nongnu.org, thuth@redhat.com, alistair.francis@wdc.com,
 peter.maydell@linaro.org, Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: Re: [PATCH for-9.0 0/3] qtest/virtio-9p-test.c: fix slow tests
Date: Wed, 27 Mar 2024 09:52:58 +0100
Message-ID: <3619944.yRKTfBRQAU@silver>
In-Reply-To: <087af5f3-dfcd-4888-936c-0ffdd955459a@ventanamicro.com>
References: <20240326132606.686025-1-dbarboza@ventanamicro.com>
 <20240326165550.05d083da@bahia>
 <087af5f3-dfcd-4888-936c-0ffdd955459a@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"
Received-SPF: pass client-ip=5.189.157.229;
 envelope-from=qemu_oss@crudebyte.com; helo=kylie.crudebyte.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Tuesday, March 26, 2024 5:07:16 PM CET Daniel Henrique Barboza wrote:
>=20
> On 3/26/24 12:55, Greg Kurz wrote:
> > Bom dia Daniel !
>=20
> Bonne apr=E8s-midi !
>=20
> >=20
> > On Tue, 26 Mar 2024 10:26:03 -0300
> > Daniel Henrique Barboza <dbarboza@ventanamicro.com> wrote:
> >=20
> >> Hi,
> >>
> >> Thomas reported in [1] a problem that happened with the RISC-V machine
> >> where some tests from virtio-9p-test.c were failing with '-m slow', i.=
e.
> >> enabling slow tests.
> >>
> >> In the end it wasn't a RISC-V specific problem. It just so happens that
> >> the recently added riscv machine nodes runs the tests from
> >> virtio-9p-test two times for each qos-test run: one with the
> >> virtio-9p-device device and another with the virtio-9p-pci. The temp d=
ir
> >> for these tests is being created at the start of qos-test and removed
> >> only at the end of qos-test, and the tests are leaving dirs and files
> >> behind. virtio-9-device tests run first, creates stuff in the temp dir,
> >> then when virtio-9p-pci tests runs again it'll fail because the previo=
us
> >> run left created dirs and files in the same temp dir. Here's a run that
> >> exemplifies the problem:
> >>
> >> $ MALLOC_PERTURB_=3D21 V=3D2 QTEST_QEMU_BINARY=3D./qemu-system-riscv64=
 ./tests/qtest/qos-test -m slow
> >> (...)
> >> # starting QEMU: exec ./qemu-system-riscv64 -qtest unix:/tmp/qtest-621=
710.sock -qtest-log /dev/null -chardev socket,path=3D/tmp/qtest-621710.qmp,=
id=3Dchar0 -mon chardev=3Dchar0,mode=3Dcontrol -display none -audio none -M=
 virt,aclint=3Don,aia=3Daplic-imsic -fsdev local,id=3Dfsdev0,path=3D'/home/=
danielhb/work/qemu/build/qtest-9p-local-7E16K2',security_model=3Dmapped-xat=
tr -device virtio-9p-device,fsdev=3Dfsdev0,mount_tag=3Dqtest -accel qtest
> >> ( goes ok ...)
> >> # starting QEMU: exec ./qemu-system-riscv64 -qtest unix:/tmp/qtest-621=
710.sock -qtest-log /dev/null -chardev socket,path=3D/tmp/qtest-621710.qmp,=
id=3Dchar0 -mon chardev=3Dchar0,mode=3Dcontrol -display none -audio none -M=
 virt,aclint=3Don,aia=3Daplic-imsic -fsdev local,id=3Dfsdev0,path=3D'/home/=
danielhb/work/qemu/build/qtest-9p-local-7E16K2',security_model=3Dmapped-xat=
tr -device virtio-9p-pci,fsdev=3Dfsdev0,addr=3D04.0,mount_tag=3Dqtest -acce=
l qtest
> >> ok 168 /riscv64/virt/generic-pcihost/pci-bus-generic/pci-bus/virtio-9p=
=2Dpci/virtio-9p/virtio-9p-tests/local/config
> >> Received response 7 (RLERROR) instead of 73 (RMKDIR)
> >> Rlerror has errno 17 (File exists)
> >> **
> >> ERROR:../tests/qtest/libqos/virtio-9p-client.c:275:v9fs_req_recv: asse=
rtion failed (hdr.id =3D=3D id): (7 =3D=3D 73)
> >>
> >> As we can see we're running both 'virtio-9p-device' tests and 'virtio-=
9p-pci'
> >> tests using the same '/home/danielhb/work/qemu/build/qtest-9p-local-7E=
16K2'
> >> temp dir.
> >>
> >=20
> >=20
> > Good catch ! I'll try to find some time to review.
> >=20
> >> The quick fix I came up with was to make each test clean themselves up
> >> after each run. The tests were also consolidated, i.e. fewer tests wit=
h the
> >> same coverage, because the 'unlikat' tests were doing the same thing t=
he
> >> 'create' tests were doing but removing stuff after. Might as well keep=
 just
> >> the 'unlikat' tests.
> >>
> >=20
> > As long as coverage is preserved, I'm fine with consolidation of the
> > checks. In any case, last call goes to Christian.
> >=20
> >> I also went ahead and reverted 558f5c42efd ("tests/9pfs: Mark "local"
> >> tests as "slow"") after realizing that the problem I was fixing is also
> >> the same problem that this patch was trying to working around with the
> >> skip [2]. I validated this change in this Gitlab pipeline:
> >>
> >=20
> > Are you sure with that ? Issues look very similar indeed but not
> > exactly the same.
>=20
> We can skip this revert if we're not sure about it. Gitlab passed with it=
 but
> perhaps this isn't evidence enough. I'll let you guys decide.

I am a bit surprised because errnos were different (file exists vs. not
supported), but indeed, it did pass in your Gitlab pipeline. So I am fine w=
ith
bringing those tests back in on Gitlab.

/Christian



