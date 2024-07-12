Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63FCFC3DA45
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jul 2024 07:54:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sSB6Q-00060m-2V; Fri, 12 Jul 2024 03:54:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Simon.Hamelin@grenoble-inp.org>)
 id 1sSB6O-00060G-1P
 for qemu-devel@nongnu.org; Fri, 12 Jul 2024 03:54:00 -0400
Received: from smtpout02-ext4.partage.renater.fr ([194.254.241.31])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Simon.Hamelin@grenoble-inp.org>)
 id 1sSB6I-0003fA-Me
 for qemu-devel@nongnu.org; Fri, 12 Jul 2024 03:53:59 -0400
Received: from zmtaauth06.partage.renater.fr (zmtaauth06.partage.renater.fr
 [194.254.241.27])
 by smtpout20.partage.renater.fr (Postfix) with ESMTP id A3A82BFA05;
 Fri, 12 Jul 2024 09:53:41 +0200 (CEST)
Received: from zmtaauth06.partage.renater.fr (localhost [127.0.0.1])
 by zmtaauth06.partage.renater.fr (Postfix) with ESMTPS id 12BCC1000EC;
 Fri, 12 Jul 2024 09:53:13 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by zmtaauth06.partage.renater.fr (Postfix) with ESMTP id F32511000D2;
 Fri, 12 Jul 2024 09:53:12 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.10.3 zmtaauth06.partage.renater.fr F32511000D2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=grenoble-inp.org;
 s=F42A61D9-9621-4693-8E8E-830FB5F1ED6E; t=1720770793;
 bh=EbgU5c3f+TDrjleduajZ23kadomJPfwe7HT4RdBJ1yU=;
 h=Message-ID:Date:MIME-Version:To:From;
 b=fv/R/PNXUzQ98QdQEb34E5ecbdK6kO6QnkU/Mw9b+tWjagYuYCbZxTOKXsKWM/rDs
 Knmi5arPg0YySFBFL6uhnD734mxzYhy3jkCTvPDEyxT32BK7lKvQDkALlgsUvUUxO/
 eEDTWq5dlPzJeWEUxKdDjVduVXgZRR5T7+ObfsQXO2iYtfCnu1EcGwswB2hEREpBUE
 ZNIjq4T0hT/XqYyxE38KQOQ4Pe1QxS/f4pYAvO/m+wqVnTeSivpyiOyI+rUtg9tozD
 GUuBt0pS11kqeiUyRZeALlXlsGxga+74AzHxJ9U3EP6IgRvgyFiaClvcm80qTKbbuj
 aPtAhmTVqhuyQ==
Received: from zmtaauth06.partage.renater.fr ([127.0.0.1])
 by localhost (zmtaauth06.partage.renater.fr [127.0.0.1]) (amavis, port 10026)
 with ESMTP id aMU23cbj5VJZ; Fri, 12 Jul 2024 09:53:12 +0200 (CEST)
Received: from 188.231.11.184 (unknown [194.254.241.249])
 by zmtaauth06.partage.renater.fr (Postfix) with ESMTPA id 975F11000EC;
 Fri, 12 Jul 2024 09:53:12 +0200 (CEST)
Message-ID: <b03c9f17-a99a-4b6e-883b-37ce092d2a57@grenoble-inp.org>
Date: Fri, 12 Jul 2024 09:53:34 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] plugins/stoptrigger: TCG plugin to stop execution
 under conditions
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, Alexandre Iooss <erdnaxe@crans.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>
References: <20240710120854.34333-2-simon.hamelin@grenoble-inp.org>
 <87jzhsqm97.fsf@draig.linaro.org>
Content-Language: en-US
From: Simon Hamelin <Simon.Hamelin@grenoble-inp.org>
In-Reply-To: <87jzhsqm97.fsf@draig.linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
X-Virus-Scanned: clamav-milter 0.103.8 at clamav04
X-Virus-Status: Clean
X-Renater-Ptge-SpamState: clean
X-Renater-Ptge-SpamScore: -100
X-Renater-Ptge-SpamCause: gggruggvucftvghtrhhoucdtuddrgeeftddrfeehgdduvdeiucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecutffgpfetvffgtfenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepkfffgggfuffvvehfhfgjtgfgsehtkeertddtvdejnecuhfhrohhmpefuihhmohhnucfjrghmvghlihhnuceoufhimhhonhdrjfgrmhgvlhhinhesghhrvghnohgslhgvqdhinhhprdhorhhgqeenucggtffrrghtthgvrhhnpeefhfejkedttddvfffgtdeileegieegvedttdeugfeflefhuddtffdttdelgeelueenucfkphepudelgedrvdehgedrvdeguddrvdegleenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeduleegrddvheegrddvgedurddvgeelpdhhvghlohepudekkedrvdefuddruddurddukeegpdhmrghilhhfrhhomhepufhimhhonhdrjfgrmhgvlhhinhesghhrvghnohgslhgvqdhinhhprdhorhhgpdhnsggprhgtphhtthhopeejpdhrtghpthhtoheprghlvgigrdgsvghnnhgvvgeslhhinhgrrhhordhorhhgpdhrtghpthhtohepqhgvmhhuqdguvghvvghlsehnohhnghhnuhdrohhrghdprhgtphhtthhopegvrhgunhgrgigvsegtrhgrnhhsrdhorhhgpdhrtghpthhtohepmhgrrdhmrghnughouhhrrhesghhmrghilhdrtghomhdprhgtphhtthhopehpihgvrhhrihgtkhdrsghouhhvihgvrheslhhi
 nhgrrhhordhorhhgpdhrtghpthhtoheprhhitghhrghrugdrhhgvnhguvghrshhonheslhhinhgrrhhordhorhhg
Content-Transfer-Encoding: quoted-printable
Received-SPF: none client-ip=194.254.241.31;
 envelope-from=Simon.Hamelin@grenoble-inp.org;
 helo=smtpout02-ext4.partage.renater.fr
X-Spam_score_int: 3
X-Spam_score: 0.3
X-Spam_bar: /
X-Spam_report: (0.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_HELO_IP_MISMATCH=2.368,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_NONE=0.001 autolearn=no autolearn_force=no
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



On 7/11/24 12:03, Alex Benn=C3=A9e wrote:
>> +static void exit_emulation(int return_code)
>> +{
>> +    exit(return_code);
>> +}
>> +
>> +static void exit_icount_reached(unsigned int cpu_index, void *udata)
>> +{
>> +    qemu_plugin_outs("icount reached, exiting\n");
>> +    exit_emulation(icount_exit_code);
>> +}
>> +
>> +static void exit_address_reached(unsigned int cpu_index, void *udata)
>> +{
>> +    uint64_t insn_vaddr =3D GPOINTER_TO_UINT(udata);
>> +    g_mutex_lock(&addrs_ht_lock);
>> +    int exit_code =3D GPOINTER_TO_INT(
>> +        g_hash_table_lookup(addrs_ht, GUINT_TO_POINTER(insn_vaddr)));
>> +    g_mutex_unlock(&addrs_ht_lock);
>> +    char *msg =3D g_strdup_printf("0x%" PRIx64 " reached, exiting\n",
>> insn_vaddr);
>=20
> Dont intermix variable declarations, put them at the top of the block.
>=20
>> +    qemu_plugin_outs(msg);
>> +    exit_emulation(exit_code);
>> +}
>=20
> How about something like:
>=20
>    static void exit_emulation(int return_code, char *message)
>    {
>        qemu_plugin_outs(message);
>        g_free(message);
>        exit(return_code);
>    }
>=20
>    static void exit_icount_reached(unsigned int cpu_index, void *udata)
>    {
>        uint64_t insn_vaddr =3D GPOINTER_TO_UINT(udata);
>        char *msg =3D g_strdup_printf("icount reached at 0x%" PRIx64 ", =
exiting\n", insn_vaddr);
>=20
>        exit_emulation(icount_exit_code, msg);
>    }
>=20
>    static void exit_address_reached(unsigned int cpu_index, void *udata=
)
>    {
>        uint64_t insn_vaddr =3D GPOINTER_TO_UINT(udata);
>        char *msg =3D g_strdup_printf("0x%" PRIx64 " reached, exiting\n"=
, insn_vaddr);
>        int exit_code;
>=20
>        g_mutex_lock(&addrs_ht_lock);
>        exit_code =3D GPOINTER_TO_INT(
>            g_hash_table_lookup(addrs_ht, GUINT_TO_POINTER(insn_vaddr)))=
;
>        g_mutex_unlock(&addrs_ht_lock);
>=20
>        exit_emulation(exit_code, msg);
>    }
>=20
>=20

Looks good to me, will definitly put that in the next patch !

>> +QEMU_PLUGIN_EXPORT int qemu_plugin_install(qemu_plugin_id_t id,
>> +                                           const qemu_info_t *info, i=
nt argc,
>> +                                           char **argv)
>> +{
>> +    addrs_ht =3D g_hash_table_new(NULL, g_direct_equal);
>> +
>> +    insn_count_sb =3D qemu_plugin_scoreboard_new(sizeof(InstructionsC=
ount));
>> +    insn_count =3D qemu_plugin_scoreboard_u64_in_struct(
>> +        insn_count_sb, InstructionsCount, insn_count);
>> +
>> +    for (int i =3D 0; i < argc; i++) {
>> +        char *opt =3D argv[i];
>> +        g_auto(GStrv) tokens =3D g_strsplit(opt, "=3D", 2);
>> +        if (g_strcmp0(tokens[0], "icount") =3D=3D 0) {
>> +            g_auto(GStrv) icount_tokens =3D g_strsplit(tokens[1], ":"=
, 2);
>> +            icount =3D g_ascii_strtoull(icount_tokens[0], NULL, 0);
>=20
>=20
>=20
>> +            if (icount < 1 || g_strrstr(icount_tokens[0], "-") !=3D
>> NULL) {
>=20
> I don't think strstoull would even parse something with - in it so I
> would just do:
>=20
>    if (icount =3D=3D 0) {
>       /* fail */
>    }
>=20

According to the GLib documentation: "Note that input with a leading=20
minus sign (-) is accepted, and will return the negation of the parsed=20
number, unless that would overflow a guint64". So i guess we need to=20
keep this check.

>> diff --git a/docs/devel/tcg-plugins.rst b/docs/devel/tcg-plugins.rst
>> index f7d7b9e3a4..954623f9bf 100644
>> --- a/docs/devel/tcg-plugins.rst
>> +++ b/docs/devel/tcg-plugins.rst
>> @@ -642,6 +642,28 @@ The plugin has a number of arguments, all of them=
 are optional:
>>     configuration arguments implies ``l2=3Don``.
>>     (default: N =3D 2097152 (2MB), B =3D 64, A =3D 16)
>>  =20
>> +- contrib/plugins/stoptrigger.c
>> +
>> +The stoptrigger plugin allows to setup triggers to stop emulation.
>> +It can be used for research purposes to launch some code and precisel=
y stop it
>> +and understand where its execution flow went.
>> +
>> +Two types of triggers can be configured: a count of instructions to s=
top at,
>> +or an address to stop at. Multiple triggers can be set at once.
>> +
>> +By default, QEMU will exit with return code 0. A custom return code c=
an be
>> +configured for each trigger using ``:CODE`` syntax.
>> +
>> +For example, to stop at the 20-th instruction with return code 41, at=
 address
>> +0xd4 with return code 0 or at address 0xd8 with return code 42::
>> +
>> +  $ qemu-system-aarch64 $(QEMU_ARGS) \
>> +    -plugin ./contrib/plugins/libstoptrigger.so,icount=3D20:41,addr=3D=
0xd4,addr=3D0xd8:42 -d plugin
>> +
>> +The plugin will log the reason of exit, for example::
>> +
>> +  0xd4 reached, exiting
>> +
>>   Plugin API
>>   =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>=20
> Otherwise it looks good to me. Unless you want to tackle additional exi=
t
> modes?
>=20
> What is your current use case for this?
>

I'm currently using this plugin to determine where my programm stop=20
after a given number of instructions executed.

--=20
Simon Hamelin

